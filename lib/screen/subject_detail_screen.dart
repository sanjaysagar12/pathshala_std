import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectDetailScreen extends StatelessWidget {
  final String subjectName;
  final IconData subjectIcon;
  final Color subjectColor;

  const SubjectDetailScreen({
    super.key,
    required this.subjectName,
    required this.subjectIcon,
    required this.subjectColor,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: colorScheme.surface,
        foregroundColor: subjectColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Subject Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    subjectColor.withOpacity(0.1),
                    subjectColor.withOpacity(0.2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: subjectColor.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    subjectIcon,
                    size: 80,
                    color: subjectColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subjectName,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore and learn with interactive content',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Learning Options
            Expanded(
              child: GridView.count(
                crossAxisCount: isTablet ? 2 : 1,
                childAspectRatio: isTablet ? 2.5 : 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildLearningCard(
                    context,
                    'Notes',
                    'Read comprehensive study materials',
                    Icons.note_alt,
                    Colors.blue,
                    () => Navigator.pushNamed(
                      context,
                      '/notes',
                      arguments: {
                        'subjectName': subjectName,
                        'subjectColor': subjectColor,
                      },
                    ),
                  ),
                  _buildLearningCard(
                    context,
                    'AI Quiz',
                    'Test your knowledge with AI-powered questions',
                    Icons.quiz,
                    Colors.orange,
                    () => Navigator.pushNamed(
                      context,
                      '/quiz',
                      arguments: {
                        'subjectName': subjectName,
                        'subjectColor': subjectColor,
                      },
                    ),
                  ),
                  _buildLearningCard(
                    context,
                    'AI Guide',
                    'Get personalized help from your AI tutor',
                    Icons.psychology,
                    Colors.purple,
                    () => Navigator.pushNamed(
                      context,
                      '/ai-guide',
                      arguments: {
                        'subjectName': subjectName,
                        'subjectColor': subjectColor,
                      },
                    ),
                  ),
                  _buildLearningCard(
                    context,
                    'Start Learning',
                    'Begin your interactive learning journey',
                    Icons.play_circle_filled,
                    Colors.green,
                    () => Navigator.pushNamed(
                      context,
                      '/learning',
                      arguments: {
                        'subjectName': subjectName,
                        'subjectColor': subjectColor,
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.13),
                color.withOpacity(0.22),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
