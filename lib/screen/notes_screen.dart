import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  final String subjectName;
  final Color subjectColor;

  const NotesScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
  });

  List<Map<String, String>> get subjectNotes {
    switch (subjectName) {
      case 'Mathematics':
        return [
          {
            'title': 'Algebra Basics',
            'content': 'Algebra is a branch of mathematics dealing with symbols and the rules for manipulating those symbols. In elementary algebra, those symbols represent quantities without fixed values, known as variables.',
          },
          {
            'title': 'Geometry Fundamentals',
            'content': 'Geometry is concerned with properties of space that are related with distance, shape, size, and relative position of figures. It includes points, lines, angles, surfaces, and solids.',
          },
          {
            'title': 'Calculus Introduction',
            'content': 'Calculus is the mathematical study of continuous change. It has two major branches: differential calculus and integral calculus, which are related by the fundamental theorem of calculus.',
          },
        ];
      case 'Science':
        return [
          {
            'title': 'Scientific Method',
            'content': 'The scientific method is a systematic approach to understanding the natural world. It involves observation, hypothesis formation, experimentation, and analysis of results.',
          },
          {
            'title': 'States of Matter',
            'content': 'Matter exists in different states: solid, liquid, gas, and plasma. Each state has distinct properties based on the arrangement and movement of particles.',
          },
          {
            'title': 'Energy and Motion',
            'content': 'Energy is the capacity to do work. It exists in various forms including kinetic energy (energy of motion), potential energy (stored energy), and thermal energy.',
          },
        ];
      case 'English':
        return [
          {
            'title': 'Grammar Essentials',
            'content': 'Grammar is the system of rules that governs the composition of sentences, phrases, and words in any language. It includes parts of speech, sentence structure, and punctuation.',
          },
          {
            'title': 'Literature Analysis',
            'content': 'Literature analysis involves examining the elements of a literary work such as plot, character, setting, theme, and style to understand the author\'s message and artistic techniques.',
          },
          {
            'title': 'Writing Techniques',
            'content': 'Effective writing involves clear organization, proper grammar, varied sentence structure, and appropriate tone for the intended audience and purpose.',
          },
        ];
      case 'History':
        return [
          {
            'title': 'Ancient Civilizations',
            'content': 'Ancient civilizations like Mesopotamia, Egypt, Greece, and Rome laid the foundations for modern society through their innovations in government, technology, and culture.',
          },
          {
            'title': 'Medieval Period',
            'content': 'The medieval period, also known as the Middle Ages, was characterized by feudalism, the rise of Christianity, and significant cultural and technological developments.',
          },
          {
            'title': 'Industrial Revolution',
            'content': 'The Industrial Revolution was a period of major industrialization that transformed economies from agriculture-based to manufacturing-based systems.',
          },
        ];
      case 'Geography':
        return [
          {
            'title': 'Physical Geography',
            'content': 'Physical geography studies natural features of Earth including landforms, climate, water bodies, and ecosystems and how they interact with each other.',
          },
          {
            'title': 'Human Geography',
            'content': 'Human geography examines the relationship between people and places, including population distribution, cultural patterns, and economic activities.',
          },
          {
            'title': 'Climate and Weather',
            'content': 'Climate refers to long-term atmospheric conditions, while weather describes short-term atmospheric conditions. Both are influenced by factors like latitude, altitude, and proximity to water bodies.',
          },
        ];
      default:
        return [
          {
            'title': 'Introduction to $subjectName',
            'content': 'This subject covers fundamental concepts and principles that form the foundation for advanced learning in this field.',
          },
          {
            'title': 'Key Concepts',
            'content': 'Understanding the core concepts is essential for mastering this subject and applying knowledge in practical situations.',
          },
          {
            'title': 'Study Tips',
            'content': 'Regular practice, active reading, and connecting concepts to real-world examples will help you excel in this subject.',
          },
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName - Notes'),
        backgroundColor: subjectColor.withOpacity(0.1),
        foregroundColor: subjectColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: subjectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Notes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comprehensive study materials for $subjectName',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subjectNotes.length,
                itemBuilder: (context, index) {
                  final note = subjectNotes[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: subjectColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.bookmark,
                                  color: subjectColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  note['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: subjectColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            note['content']!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
