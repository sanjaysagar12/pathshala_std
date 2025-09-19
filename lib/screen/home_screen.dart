import 'package:flutter/material.dart';
import '../data/subjects_data.dart';
import '../components/subject_card.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final subjects = SubjectsData.subjects;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pathshala', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
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
              child: subjects.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emoji_emotions, size: 64, color: colorScheme.primary.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text(
                            'No subjects found!',
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: colorScheme.primary),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add a subject to get started.\nLearning is more fun with friends! 🎉',
                            style: GoogleFonts.inter(fontSize: 14, color: colorScheme.onSurface.withOpacity(0.7)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        final subject = subjects[index];
                        return SubjectCard(
                          name: subject['name'],
                          icon: subject['icon'],
                          color: subject['color'],
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
