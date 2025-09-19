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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          subjectName, 
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          )
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Simple Subject Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: subjectColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      subjectIcon,
                      size: 48,
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    subjectName,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Interactive learning made simple',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Simple Learning Cards Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isTablet ? 2 : 1,
              childAspectRatio: isTablet ? 3.5 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildSimpleCard(
                  context,
                  'Study Notes',
                  'Comprehensive study materials',
                  Icons.book_outlined,
                  const Color(0xFF4285F4),
                  () => Navigator.pushNamed(
                    context,
                    '/notes',
                    arguments: {
                      'subjectName': subjectName,
                      'subjectColor': subjectColor,
                    },
                  ),
                ),
                _buildSimpleCard(
                  context,
                  'Practice Quiz',
                  'Test your knowledge',
                  Icons.quiz_outlined,
                  const Color(0xFFFF9800),
                  () => Navigator.pushNamed(
                    context,
                    '/quiz',
                    arguments: {
                      'subjectName': subjectName,
                      'subjectColor': subjectColor,
                    },
                  ),
                ),
                _buildSimpleCard(
                  context,
                  'AI Assistant',
                  'Get help from AI tutor',
                  Icons.smart_toy_outlined,
                  const Color(0xFF9C27B0),
                  () => Navigator.pushNamed(
                    context,
                    '/ai-guide',
                    arguments: {
                      'subjectName': subjectName,
                      'subjectColor': subjectColor,
                    },
                  ),
                ),
                _buildSimpleCard(
                  context,
                  'Start Learning',
                  'Begin interactive lessons',
                  Icons.play_circle_outline,
                  const Color(0xFF4CAF50),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  