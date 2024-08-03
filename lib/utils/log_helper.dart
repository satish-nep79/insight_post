import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class LogHelper {
  static const String _errorTag = "ERROR";
  static const String _warningTag = "WARNING";
  static const String _infoTag = "INFO";
  static const String _debugTag = "DEBUG";

  static void error({
    required String title,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
        title: title,
        tag: _errorTag,
        error: error,
        stackTrace: stackTrace,
        message: message);
  }

  static void debug({
    required String title,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
        title: title,
        tag: _debugTag,
        error: error,
        stackTrace: stackTrace,
        message: message);
  }

  static void info({
    required String title,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
        title: title,
        tag: _infoTag,
        error: error,
        stackTrace: stackTrace,
        message: message);
  }

  static void warning({
    required String title,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
        title: title,
        tag: _warningTag,
        error: error,
        stackTrace: stackTrace,
        message: message);
  }

  static void _log({
    required String title,
    required String tag,
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    final logMessage = _formattedLogMessage(
      title: title,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      message: message,
    );

    switch (tag) {
      case _errorTag:
        developer.log(
          _colorizeError(logMessage),
          name: tag,
          time: DateTime.now().toLocal(),
          level: 1000,
        );
      case _warningTag:
        developer.log(
          _colorizeWarning(logMessage),
          name: tag,
          time: DateTime.now().toLocal(),
          level: 900,
        );
      case _infoTag:
        developer.log(
          _colorizeInfo(logMessage),
          name: tag,
          time: DateTime.now().toLocal(),
          level: 800,
        );
      case _debugTag:
        developer.log(
          _colorizeDebug(logMessage),
          name: tag,
          time: DateTime.now().toLocal(),
          level: 500,
        );
      default:
    }
  }

  static String _formattedLogMessage({
    required String title,
    String? message,
    required String tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final formattedDate = DateTime.now().toLocal().toString();
    final formattedError = (error != null) ? 'Error: $error' : "";
    final formattedStackTrace =
        (stackTrace != null) ? "Stack Trace: $stackTrace" : "";
    final formattedMessage = (message != null) ? "\nMessage: $message" : "";
    final logMessage = '''+-------------------------------------------------+
Log Date Time: $formattedDate
Title : $title$formattedMessage
$formattedError
$formattedStackTrace
+-------------------------------------------------+''';

    return logMessage;
  }

  /// Colorizes VSCode terminal output to Blue Color
  static String _colorizeInfo(String msg) => '\x1B[34m$msg\x1B[0m';

  /// Colorizes VSCode terminal output to Yellow Color
  static String _colorizeWarning(String msg) => '\x1B[33m$msg\x1B[0m';

  /// Colorizes VSCode terminal output to Red Color
  static String _colorizeError(String msg) => '\x1B[31m$msg\x1B[0m';

  /// Colorizes VSCode terminal output to Cyan Color
  static String _colorizeDebug(String msg) => '\x1B[36m$msg\x1B[0m';
}
