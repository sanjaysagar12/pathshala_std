import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isOutlined;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool isTeacher; // for color coding

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isOutlined = false,
    this.isLoading = false,
    this.width,
    this.padding,
    this.isTeacher = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final bool isTeacher = widget.isTeacher;

    // Gradient for student/teacher
    final Gradient gradient = LinearGradient(
      colors: isTeacher
          ? [teacherGreen, teacherGreenDark]
          : [studentOrange, studentOrangeDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Color fallbackBg = isTeacher
        ? (isDark ? teacherGreenDark : teacherGreen)
        : (isDark ? studentOrangeDark : studentOrange);

    Widget buttonChild = widget.isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.textColor ?? Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(widget.icon, size: 18, color: widget.textColor ?? Colors.white),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: widget.textColor ?? Colors.white,
                ),
              ),
            ],
          );

    final double scale = _pressed ? 0.97 : 1.0;

    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 80),
          curve: Curves.easeOut,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor: (isTeacher ? teacherGreen : studentOrange).withOpacity(0.15),
              highlightColor: Colors.transparent,
              onTap: widget.isLoading ? null : widget.onPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: widget.isOutlined ? null : gradient,
                  color: widget.isOutlined
                      ? Colors.transparent
                      : (widget.backgroundColor ?? null),
                  borderRadius: BorderRadius.circular(12),
                  border: widget.isOutlined
                      ? Border.all(
                          color: widget.backgroundColor ?? fallbackBg,
                          width: 2,
                        )
                      : null,
                  boxShadow: [
                    if (!widget.isOutlined)
                      BoxShadow(
                        color: (isTeacher ? teacherGreen : studentOrange).withOpacity(0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: buttonChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
