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
      // Curriculum Subjects
      'assets/images/subjects/English.png',
      'assets/images/subjects/Punjabi.png',
      'assets/images/subjects/Hindi.png',
      'assets/images/subjects/Mathematics.png',
      'assets/images/subjects/Science.png',
      'assets/images/subjects/History.png',
      // Additional Subjects
      'assets/images/subjects/Art&Craft.png',
      'assets/images/subjects/ComputerScience.png',
      'assets/images/subjects/Cooking.png',
      'assets/images/subjects/Drama.png',
      'assets/images/subjects/Music.png',
      'assets/images/subjects/Sports.png',
    ];

    debugPrint('🔍 Testing asset availability...');
    for (String path in assetPaths) {
      await assetExists(path);
    }
    debugPrint('✅ Asset testing completed');
  }
}
