import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final List<Color> colors;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final double? width;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.colors = const [AppColors.primary, AppColors.primaryLight],
    this.borderRadius = 14,
    this.padding,
    this.icon,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [colors.first.withOpacity(0.5), colors.last.withOpacity(0.5)]
                : colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutlineGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final List<Color> colors;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const OutlineGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.colors = const [AppColors.primary, AppColors.secondary],
    this.borderRadius = 14,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colors.first, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: colors.first,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
