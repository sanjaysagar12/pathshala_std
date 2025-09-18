import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: subjectColor.withOpacity(0.1),
        foregroundColor: subjectColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
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
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore and learn with interactive content',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
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
                crossAxisCount: 1,
                childAspectRatio: 3,
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
                    () => _showComingSoon(context, 'AI Quiz'),
                  ),
                  _buildLearningCard(
                    context,
                    'Start Learning',
                    'Begin your interactive learning journey',
                    Icons.play_circle_filled,
                    Colors.green,
                    () => _showComingSoon(context, 'Start Learning'),
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
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.2),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
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

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
