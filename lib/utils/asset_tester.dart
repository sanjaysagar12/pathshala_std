import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetTester {
  static Future<bool> assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      debugPrint('✅ Asset found: $assetPath');
      return true;
    } catch (e) {
      debugPrint('❌ Asset not found: $assetPath - Error: $e');
      return false;
    }
  }

  static Future<void> testAllSubjectAssets() async {
    final List<String> assetPaths = [
      'assets/images/logo.png',
      'assets/images/subjects/Mathematics.png',
      'assets/images/subjects/Science.png',
      'assets/images/subjects/English.png',
      'assets/images/subjects/History.png',
      'assets/images/subjects/Geography.png',
      'assets/images/subjects/Physics.png',
      'assets/images/subjects/Chemistry.png',
      'assets/images/subjects/Biology.png',
    ];

    debugPrint('🔍 Testing asset availability...');
    for (String path in assetPaths) {
      await assetExists(path);
    }
    debugPrint('✅ Asset testing completed');
  }
}
