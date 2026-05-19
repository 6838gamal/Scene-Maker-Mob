import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        foregroundColor: AppColors.textPrimary,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.surface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cardLight,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightSurface,
        background: AppColors.lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        onBackground: AppColors.lightTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: AppColors.lightTextPrimary,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.lightSurface,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightCard,
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  static TextTheme textTheme(bool isArabic) {
    if (isArabic) {
      return TextTheme(
        displayLarge: GoogleFonts.cairo(fontSize: 32, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.cairo(fontSize: 26, fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w600),
        headlineLarge: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w500),
        titleSmall: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.ibmPlexSansArabic(fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.ibmPlexSansArabic(fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: GoogleFonts.ibmPlexSansArabic(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.w500),
      );
    }
    return TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700),
      displaySmall: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
      headlineLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
    );
  }
}
