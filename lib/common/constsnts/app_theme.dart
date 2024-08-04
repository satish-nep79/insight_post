import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insight_post/common/constsnts/app_colors.dart';
import 'package:insight_post/common/constsnts/app_text_styles.dart';

class AppTheme {
  static ThemeData basicTheme() {
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,);

    return ThemeData.dark().copyWith(
      textTheme: getBasicTextTheme(),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondaryColor,
        iconSize: 24,
        sizeConstraints: BoxConstraints(
          maxHeight: 48,
          maxWidth: 48,
          minHeight: 48,
          minWidth: 48,
        ),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        outline: AppColors.lGray,
        surface: AppColors.onSurfaceColor,
        onSurface: AppColors.textColor,
        onSurfaceVariant: AppColors.secondaryTextColor,
        error: AppColors.errorColor,
        inverseSurface: AppColors.snackBarBg,
      ),
    );
  }

  static TextTheme getBasicTextTheme() {
    return ThemeData.light()
        .textTheme
        .copyWith(
          displayLarge: AppTextStyles.displayLarge(),
          displayMedium: AppTextStyles.displayMedium(),
          displaySmall: AppTextStyles.displaySmall(),
          headlineLarge: AppTextStyles.headlineLarge(),
          headlineMedium: AppTextStyles.headlineMedium(),
          headlineSmall: AppTextStyles.headlineSmall(),
          bodyLarge: AppTextStyles.bodyLarge(),
          bodyMedium: AppTextStyles.bodyMedium(),
          bodySmall: AppTextStyles.bodySmall(),
          labelLarge: AppTextStyles.labelLarge(),
          labelMedium: AppTextStyles.labelMeduim(),
          labelSmall: AppTextStyles.labelSmall(),
        )
        .apply(
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
          decorationColor: AppColors.secondaryTextColor,
        );
  }
}
