import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/core/chat.dart';
import 'package:flutter_gemma/core/model.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

import 'model_downloader_service.dart';

/// A small service that encapsulates the LLM (flutter_gemma) lifecycle
/// and exposes a simple API for the UI.
class AIModelService {
  AIModelService({ModelDownloaderService? downloader}) : _downloader = downloader ?? ModelDownloaderService();

  final ModelDownloaderService _downloader;
  InferenceModel? _inferenceModel;
  InferenceChat? _chat;

  /// True while the model is being prepared/initialized.
  bool get isInitialized => _chat != null && _inferenceModel != null;

  /// Initialize the model. Progress callback will be called with values
  /// between 0 and 1 when a download is performed.
  Future<void> initialize({required void Function(double progress)? onProgress, required void Function(String message) onStatus}) async {
    onStatus('Initializing...');

    try {
      // Cleanup any previous instances
      await cleanup();

      final gemma = FlutterGemmaPlugin.instance;

      final isInstalled = await _downloader.isModelInstalled();
      if (!isInstalled) {
        onStatus('Downloading AI Model...');
        await _downloader.downloadModel(onProgress: (p) {
          try {
            onProgress?.call(p);
          } catch (_) {}
        });
      }

      onStatus('Initializing model...');

      final modelPath = await _downloader.getModelFilePath();
      await gemma.modelManager.installModelFromAsset(modelPath);

      _inferenceModel = await gemma.createModel(
        modelType: ModelType.gemmaIt,
        supportImage: false,
        maxTokens: 2048,
      );

      _chat = await _inferenceModel!.createChat(supportImage: false);
    } catch (e) {
      if (kDebugMode) print('AIModelService.initialize error: $e');
      rethrow;
    }
  }

  /// Add a user message and return a stream of text tokens for the response.
  /// The stream yields strings progressively as the model generates them.
  Stream<String> sendMessage(String message) async* {
    if (_chat == null) throw StateError('Model not initialized');

    // Add the user query as a chunk
    // Log the full prompt (visible in `flutter logs`) in debug mode before feeding to the model
    if (kDebugMode) {
      try {
        developer.log('AIModelService - prompt:\n$message', name: 'AIModelService');
      } catch (_) {}
    }

    await _chat!.addQueryChunk(Message(text: message, isUser: true));

    final tokenStream = _chat!.generateChatResponseAsync();

    // The tokens are TextResponse objects when using flutter_gemma; transform them
    await for (final token in tokenStream) {
      String tokenText = token.toString();
      if (tokenText.startsWith('TextResponse("') && tokenText.endsWith('")')) {
        tokenText = tokenText.substring(14, tokenText.length - 2);
        tokenText = tokenText.replaceAll(r'\n', '\n').replaceAll(r'\"', '"').replaceAll(r'\\', '\\');
      } else if (tokenText.startsWith('TextResponse(') && tokenText.endsWith(')')) {
        tokenText = tokenText.substring(12, tokenText.length - 1);
      }

      yield tokenText;
    }
  }

  /// Convenience helper that composes a prompt from a template and user input.
  ///
  /// The template should include the substring `{input}` which will be replaced
  /// by the user's input. If `{input}` is not present the userInput will be
  /// appended to the template separated by a newline.
  Stream<String> sendMessageWithTemplate(String promptTemplate, String userInput) async* {
    final composed = promptTemplate.contains('{input}')
        ? promptTemplate.replaceAll('{input}', userInput)
        : '$promptTemplate\n$userInput';

    // Delegate to existing sendMessage stream
    yield* sendMessage(composed);
  }

  /// Cleanup model and chat instances.
  Future<void> cleanup() async {
    try {
      _chat = null;
      if (_inferenceModel != null) {
        await _inferenceModel!.close();
        _inferenceModel = null;
      }
    } catch (e) {
      if (kDebugMode) print('AIModelService.cleanup error: $e');
    }
  }
}
