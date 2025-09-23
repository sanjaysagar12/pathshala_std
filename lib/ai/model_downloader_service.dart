import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../conf.env.dart';

class ModelDownloaderService {
  static const String modelUrl = 'https://huggingface.co/litert-community/gemma-3-270m-it/resolve/main/gemma3-270m-it-q8.task';
  static const String modelFilename = 'gemma3-270m-it-q8.task';
  static const String _preferenceKey = 'model_downloaded_$modelFilename';


  Future<String> getModelFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$modelFilename';
  }

  Future<bool> isModelInstalled() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_preferenceKey) ?? false) {
      final filePath = await getModelFilePath();
      final file = File(filePath);
      if (file.existsSync()) {
        return true;
      }
    }

    try {
      final filePath = await getModelFilePath();
      final file = File(filePath);

      final Map<String, String> headers = accessToken.isNotEmpty
          ? {'Authorization': 'Bearer $accessToken'}
          : {};
      final headResponse = await http.head(
        Uri.parse(modelUrl),
        headers: headers,
      );

      if (headResponse.statusCode == 200) {
        final contentLengthHeader = headResponse.headers['content-length'];
        if (contentLengthHeader != null) {
          final remoteFileSize = int.parse(contentLengthHeader);
          if (file.existsSync() && await file.length() == remoteFileSize) {
            await prefs.setBool(_preferenceKey, true);
            return true;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking model existence: $e');
      }
    }
    await prefs.setBool(_preferenceKey, false);
    return false;
  }

  Future<void> downloadModel({
    required Function(double) onProgress,
  }) async {
    http.StreamedResponse? response;
    IOSink? fileSink;
    final prefs = await SharedPreferences.getInstance();

    try {
      final filePath = await getModelFilePath();
      final file = File(filePath);

      int downloadedBytes = 0;
      if (file.existsSync()) {
        downloadedBytes = await file.length();
      }

      final request = http.Request('GET', Uri.parse(modelUrl));
      if (accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      if (downloadedBytes > 0) {
        request.headers['Range'] = 'bytes=$downloadedBytes-';
      }

      response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 206) {
        final contentLength = response.contentLength ?? 0;
        final totalBytes = downloadedBytes + contentLength;
        fileSink = file.openWrite(mode: FileMode.append);

        int received = downloadedBytes;

        await for (final chunk in response.stream) {
          fileSink.add(chunk);
          received += chunk.length;
          onProgress(totalBytes > 0 ? received / totalBytes : 0.0);
        }

        await prefs.setBool(_preferenceKey, true);
      } else {
        await prefs.setBool(_preferenceKey, false);
        if (kDebugMode) {
          print('Failed to download model. Status code: ${response.statusCode}');
        }
        throw Exception('Failed to download the model.');
      }
    } catch (e) {
      await prefs.setBool(_preferenceKey, false);
      if (kDebugMode) {
        print('Error downloading model: $e');
      }
      rethrow;
    } finally {
      if (fileSink != null) await fileSink.close();
    }
  }
}