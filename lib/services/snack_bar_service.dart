import 'package:flutter/material.dart';
import 'package:insight_post/common/constsnts/app_values.dart';
import 'package:insight_post/common/widgets/ap_snackbar.dart';

class SnackBarService {
  static final GlobalKey<ScaffoldMessengerState> _messageKey =
      AppValues.snackBarMessengerKey;

  void showSuccess({String? title, String? message}) {
    _messageKey.currentState?.showSnackBar(AppSnackBar.getSnackBar(
      type: AppSnackBarType.success,
      message: message,
      title: title,
    ));
  }

  void showError({String? title, String? message}) {
    _messageKey.currentState?.showSnackBar(AppSnackBar.getSnackBar(
      type: AppSnackBarType.error,
      message: message,
      title: title,
    ));
  }

  void showInfo({String? title, required String message}) {
    _messageKey.currentState?.showSnackBar(AppSnackBar.getSnackBar(
      type: AppSnackBarType.info,
      message: message,
      title: title,
    ));
  }

  void showWarning({String? title, required String message}) {
    _messageKey.currentState?.showSnackBar(AppSnackBar.getSnackBar(
      type: AppSnackBarType.warning,
      message: message,
      title: title,
    ));
  }
}
