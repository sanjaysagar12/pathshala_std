import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? image;
  final double progress;
  final int totalLessons;
  final int completedLessons;

  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
    this.image,
    this.progress = 0.0,
    this.totalLessons = 0,
    this.completedLessons = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Container(
        height: 300, // Increased height to fix overflow
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section - Top
            Container(
              height: 160, // Fixed height for image section
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: color.withOpacity(0.1),
              ),
              child: image != null 
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color.withOpacity(0.2),
                                  color.withOpacity(0.4),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: 48,
                                    color: color,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Image not found',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withOpacity(0.2),
                            color.withOpacity(0.4),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 64,
                          color: color,
                        ),
                      ),
                    ),
            ),
            
            // Content Section - Bottom (Fixed height)
            SizedBox(
              height: 140, // Fixed height for content section
              child: Padding(
                padding: const EdgeInsets.all(14), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Name
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 17, // Slightly reduced
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4), // Reduced spacing
                    
                    // Progress Text
                    Text(
                      '$completedLessons of $totalLessons lessons completed',
                      style: GoogleFonts.inter(
                        fontSize: 12, // Reduced font size
                        color: Colors.grey[600],
                      ),
                    ),
                    
                    const SizedBox(height: 8), // Reduced spacing
                    
                    // Progress Bar
                    Container(
                      width: double.infinity,
                      height: 4, // Reduced height
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color, color.withOpacity(0.7)],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 3), // Reduced spacing
                    
                    // Progress Percentage
                    Text(
                      '${(progress * 100).toInt()}% Complete',
                      style: GoogleFonts.inter(
                        fontSize: 10, // Reduced font size
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Explore Button
                    SizedBox(
                      width: double.infinity,
                      height: 34, // Reduced button height
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: studentOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                        child: Text(
                          'Explore',
                          style: GoogleFonts.inter(
                            fontSize: 13, // Reduced font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
