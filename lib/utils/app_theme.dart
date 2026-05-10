import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1D4ED8);
  static const accent = Color(0xFF0EA5E9);
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const inputFill = Color(0xFFF1F5F9);
  static const border = Color(0xFFD1D5DB);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF4B5563);
  static const icon = Color(0xFF3B82F6);
  static const error = Color(0xFFEF4444);
}

class AppFontFamily {
  AppFontFamily._();

  static const primary = 'Times New Roman';
}

class AppFontSizes {
  AppFontSizes._();

  static const double heading1 = 22.0;
  static const double heading2 = 18.0;
  static const double body = 16.0;
  static const double label = 14.0;
  static const double caption = 12.0;
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headline => TextStyle(
        fontFamily: AppFontFamily.primary,
        fontSize: AppFontSizes.heading1.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionLabel => TextStyle(
        fontFamily: AppFontFamily.primary,
        fontSize: AppFontSizes.label.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get fieldHint => TextStyle(
        fontFamily: AppFontFamily.primary,
        fontSize: AppFontSizes.body.sp,
        color: AppColors.textSecondary,
      );

  static TextStyle get buttonLabel => TextStyle(
        fontFamily: AppFontFamily.primary,
        fontSize: AppFontSizes.body.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFontFamily.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        background: AppColors.background,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.heading1.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.heading2.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.body.sp,
          color: AppColors.textPrimary,
        ),
        labelLarge: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.label.sp,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.caption.sp,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: TextStyle(
          fontFamily: AppFontFamily.primary,
          fontSize: AppFontSizes.heading2.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actionsIconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
