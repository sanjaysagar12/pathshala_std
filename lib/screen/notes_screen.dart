import 'package:flutter/material.dart';
import '../data/notes_data.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesScreen extends StatelessWidget {
  final String subjectName;
  final Color subjectColor;

  const NotesScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
  });

  @override
  Widget build(BuildContext context) {
    final subjectNotes = NotesData.getSubjectNotes(subjectName);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName - Notes', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: colorScheme.surface,
        foregroundColor: subjectColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Notes',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comprehensive study materials for $subjectName',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: subjectNotes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book, size: 64, color: colorScheme.primary.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text(
                            'No notes found!',
                            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: colorScheme.primary),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check back soon for more notes.\nKeep your learning streak going! 🔥',
                            style: GoogleFonts.inter(fontSize: 14, color: colorScheme.onSurface.withOpacity(0.7)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: subjectNotes.length,
                      itemBuilder: (context, index) {
                        final note = subjectNotes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: subjectColor.withOpacity(0.13),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.bookmark,
                                        color: subjectColor,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        note['title']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: subjectColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  note['content']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    height: 1.6,
                                    color: colorScheme.onSurface,
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