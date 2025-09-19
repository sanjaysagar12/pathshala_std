import 'package:flutter/material.dart';
import '../data/subjects_data.dart';
import '../components/subject_card.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/asset_tester.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Test assets when screen loads
    AssetTester.testAllSubjectAssets();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final curriculumSubjects = SubjectsData.curriculumSubjects;
    final additionalSubjects = SubjectsData.additionalSubjects;
    
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Text('Pathshala', style: GoogleFonts.inter(fontWeight: FontWeight.bold));
          },
        ),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Pathshala!',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a subject to start learning',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    ...curriculumSubjects.map((subject) => _buildSubjectCard(subject)),
                    
                    const SizedBox(height: 24),
                    
                    // Additional Subjects Section
                    _buildSectionHeader('Additional Subjects', colorScheme),
                    const SizedBox(height: 12),
                    ...additionalSubjects.map((subject) => _buildSubjectCard(subject)),
                    
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: studentOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: studentOrange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: studentOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              title.contains('Curriculum') ? Icons.school : Icons.extension,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFF8A2B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SubjectCard(
        name: subject['name'],
        icon: subject['icon'],
        color: subject['color'],
        image: subject['image'],
        progress: subject['progress']?.toDouble() ?? 0.0,
        totalLessons: subject['totalLessons'] ?? 0,
        completedLessons: subject['completedLessons'] ?? 0,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/subject-detail',
            arguments: {
              'name': subject['name'],
              'icon': subject['icon'],
              'color': subject['color'],
            },
          );
        },
      ),
    );
  }
}