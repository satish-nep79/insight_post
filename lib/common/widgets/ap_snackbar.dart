import 'package:flutter/material.dart';
import 'package:insight_post/common/constsnts/app_colors.dart';
import 'package:insight_post/common/constsnts/app_text_styles.dart';

enum AppSnackBarType { success, error, warning, info }

class AppSnackBar {
  final String? message;
  final String? title;
  final AppSnackBarType type;
  const AppSnackBar({
    this.message,
    this.title,
    required this.type,
  });

  static SnackBar getSnackBar(
      {String? title, String? message, required AppSnackBarType type}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            _getIcon(type),
            size: 32,
            color: _getColor(type),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTitle(type),
                  style: AppTextStyles.bodyLarge().copyWith(
                    color: _getColor(type),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message ?? _getMessage(type),
                  maxLines: 2,
                  style: AppTextStyles.bodyLarge()
                      .copyWith(color: AppColors.textColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static IconData _getIcon(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return Icons.check_circle_outline;
      case AppSnackBarType.error:
        return Icons.cancel_outlined;
      case AppSnackBarType.warning:
        return Icons.error_outline_outlined;
      case AppSnackBarType.info:
        return Icons.info_outline_rounded;
    }
  }

  static Color _getColor(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return AppColors.successColor;
      case AppSnackBarType.error:
        return AppColors.errorColor;
      case AppSnackBarType.warning:
        return const Color(0xFF1E79EC);
      case AppSnackBarType.info:
        return const Color(0xFFD5AB12);
    }
  }

  static String _getTitle(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return "Success";
      case AppSnackBarType.error:
        return "Error!";
      case AppSnackBarType.warning:
        return "Info";
      case AppSnackBarType.info:
        return "Warning";
    }
  }

  static String _getMessage(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return "The action was successful";
      case AppSnackBarType.error:
        return "Sorry!! something went wrong";
      case AppSnackBarType.warning:
        return "";
      case AppSnackBarType.info:
        return "";
    }
  }
}
