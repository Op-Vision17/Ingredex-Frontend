import 'package:flutter/material.dart';

/// Global snackbars via [MaterialApp.scaffoldMessengerKey]. Uses [SnackBarThemeData]
/// from the active [Theme] so light/dark styling stays consistent.
class SnackBarService {
  SnackBarService._();

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
        ),
      );
  }
}
