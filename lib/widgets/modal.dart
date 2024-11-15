// ui_components.dart
import 'package:flutter/material.dart';

void showMessageDialog({
  required BuildContext context,
  required String title,
  required String message,
  VoidCallback? onDismiss,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              if (onDismiss != null)
                onDismiss(); // Execute callback if provided
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
