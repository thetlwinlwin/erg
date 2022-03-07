import 'package:flutter/material.dart';

void errorSnackBar(String message, BuildContext context) {
  final _snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.error_outline,
          size: 32,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(message),
        ),
      ],
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
}
