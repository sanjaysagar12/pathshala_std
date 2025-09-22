import 'package:flutter/material.dart';
// import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? backgroundColor;
  final bool isTeacher;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.backgroundColor,
    this.isTeacher = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Gradient glassGradient = LinearGradient(
      colors: isDark
          ? [const Color(0xFF1E293B).withOpacity(0.7), Colors.white.withOpacity(0.04)]
          : [const Color(0xFFFAFAFA).withOpacity(0.7), Colors.white.withOpacity(0.2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    final Gradient progressGradient = LinearGradient(
      colors: isTeacher
          ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
          : [const Color(0xFFFF8A2B), const Color(0xFFFF7A1A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Stack(
      children: [
        child,
        if (isLoading)
          AnimatedOpacity(
            opacity: isLoading ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: backgroundColor ?? Colors.black.withOpacity(0.25),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: glassGradient,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E293B).withOpacity(0.3) : const Color(0xFFFAFAFA).withOpacity(0.3),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1200),
                        builder: (context, value, child) {
                          return ShaderMask(
                            shaderCallback: (rect) => progressGradient.createShader(rect),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 4,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        message ?? (isTeacher ? 'Syncing for teachers...' : 'Syncing for students...'),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isTeacher
                            ? 'You are making a difference!'
                            : 'Keep going, you are doing great!',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
