import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF13131A);
  static const Color card = Color(0xFF1C1C27);
  static const Color cardLight = Color(0xFF22222F);

  // Accents
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFF9D61FF);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color secondary = Color(0xFF06B6D4);
  static const Color accent = Color(0xFFD4AF37);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1C1C27), Color(0xFF13131A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF59E0B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0B8);
  static const Color textMuted = Color(0xFF4A4A6A);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Light theme
  static const Color lightBackground = Color(0xFFF8F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F1F8);
  static const Color lightTextPrimary = Color(0xFF0A0A0F);
  static const Color lightTextSecondary = Color(0xFF4A4A6A);
}
