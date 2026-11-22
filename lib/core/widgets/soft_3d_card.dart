import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// 3D Soft-Realism Card featuring tactile depth, soft bevel highlight and organic ambient shadow
class Soft3DCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? baseColor;
  final Gradient? gradient;
  final Border? border;
  final VoidCallback? onTap;
  final bool isPressed;
  final double elevation;

  const Soft3DCard({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
    this.baseColor,
    this.gradient,
    this.border,
    this.onTap,
    this.isPressed = false,
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = baseColor ?? Colors.white;

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: gradient == null ? effectiveColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: AppColors.midnight.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFF1E1B4B).withValues(alpha: 0.06),
                  blurRadius: elevation * 2.5,
                  spreadRadius: -2,
                  offset: Offset(0, elevation),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.95),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      child: child,
    );

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}
