import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static final Logger _logger = Logger();

  static void handleError(dynamic error, StackTrace? stackTrace, {String? context}) {
    _logger.e('Error in $context: $error', error: error, stackTrace: stackTrace);
  }

  static void showErrorDialog(BuildContext context, String message, {String title = 'Error'}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}