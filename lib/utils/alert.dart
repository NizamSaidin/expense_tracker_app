import 'dart:async';

import 'package:flutter/material.dart';

enum AlertType {
  success,
  error,
  warning,
  info;
}

class Alert {
  const Alert._();

  static getAlertColor(BuildContext context, {AlertType alertType = AlertType.info}) {
    switch (alertType) {
      case AlertType.success:
        return Theme.of(context).colorScheme.primaryContainer;
      case AlertType.error:
        return Theme.of(context).colorScheme.error;
      case AlertType.warning:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case AlertType.info:
        return Theme.of(context).colorScheme.secondaryContainer;
    }
  }

  static showSnackbar(BuildContext context, String message, {AlertType alertType = AlertType.info}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: getAlertColor(context, alertType: alertType),
      ),
    );
  }

  static Future<bool?> showConfirmationDialog({required BuildContext context, String? description, String? title}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Confirmation'),
          content: Text(description ?? 'Are you sure?'),
          actions: [
            TextButton(
              child: const Text('NO'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }
}
