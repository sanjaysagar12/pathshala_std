import 'package:flutter/material.dart';

class SubjectsData {
  static const List<Map<String, dynamic>> curriculumSubjects = [
    {
      'name': 'English',
      'icon': Icons.language,
      'color': Colors.blue,
      'image': 'assets/images/subjects/English.png',
      'progress': 0.8,
      'totalLessons': 10,
      'completedLessons': 8,
      'category': 'Curriculum',
    },
    {
      'name': 'Punjabi',
      'icon': Icons.translate,
      'color': Colors.orange,
      'image': 'assets/images/subjects/Punjabi.png',
      'progress': 0.6,
      'totalLessons': 8,
      'completedLessons': 5,
      'category': 'Curriculum',
    },
    {
      'name': 'Hindi',
      'icon': Icons.text_fields,
      'color': Colors.green,
      'image': 'assets/images/subjects/Hindi.png',
      'progress': 0.7,
      'totalLessons': 9,
      'completedLessons': 6,
      'category': 'Curriculum',
    },
    {
      'name': 'Mathematics',
      'icon': Icons.calculate,
      'color': Colors.indigo,
      'image': 'assets/images/subjects/Mathematics.png',
      'progress': 0.9,
      'totalLessons': 12,
      'completedLessons': 11,
      'category': 'Curriculum',
    },
    {
      'name': 'Science',
      'icon': Icons.science,
      'color': Colors.teal,
      'image': 'assets/images/subjects/Science.png',
      'progress': 0.5,
      'totalLessons': 11,
      'completedLessons': 6,
      'category': 'Curriculum',
    },
    {
      'name': 'History',
      'icon': Icons.history_edu,
      'color': Colors.brown,
      'image': 'assets/images/subjects/History.png',
      'progress': 0.4,
      'totalLessons': 8,
      'completedLessons': 3,
      'category': 'Curriculum',
    },
  ];

  static const List<Map<String, dynamic>> additionalSubjects = [
    {
      'name': 'Art & Craft',
      'icon': Icons.palette,
      'color': Colors.pink,
      'image': 'assets/images/subjects/Art&Craft.png',
      'progress': 0.3,
      'totalLessons': 6,
      'completedLessons': 2,
      'category': 'Additional',
    },
    {
      'name': 'Computer Science',
      'icon': Icons.computer,
      'color': Colors.purple,
      'image': 'assets/images/subjects/ComputerScience.png',
      'progress': 0.7,
      'totalLessons': 10,
      'completedLessons': 7,
      'category': 'Additional',
    },
    {
      'name': 'Cooking',
      'icon': Icons.restaurant,
      'color': Colors.amber,
      'image': 'assets/images/subjects/Cooking.png',
      'progress': 0.2,
      'totalLessons': 5,
      'completedLessons': 1,
      'category': 'Additional',
    },
    {
      'name': 'Drama',
      'icon': Icons.theater_comedy,
      'color': Colors.red,
      'image': 'assets/images/subjects/Drama.png',
      'progress': 0.6,
      'totalLessons': 7,
      'completedLessons': 4,
      'category': 'Additional',
    },
    {
      'name': 'Music',
      'icon': Icons.music_note,
      'color': Colors.deepPurple,
      'image': 'assets/images/subjects/Music.png',
      'progress': 0.8,
      'totalLessons': 8,
      'completedLessons': 6,
      'category': 'Additional',
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Colors.lightGreen,
      'image': 'assets/images/subjects/Sports.png',
      'progress': 0.9,
      'totalLessons': 6,
      'completedLessons': 5,
      'category': 'Additional',
    },
  ];

  // Combined list for backward compatibility
  static List<Map<String, dynamic>> get subjects {
    return [...curriculumSubjects, ...additionalSubjects];
  }

  // Get subjects by category
  static List<Map<String, dynamic>> getSubjectsByCategory(String category) {
    return subjects.where((subject) => subject['category'] == category).toList();
  }
}
