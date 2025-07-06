import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWarning {
  static void showWarning(String message, [bool isWarning = true]) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isWarning ? Colors.redAccent : Colors.white,
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Row(
          children: [
            Icon(
                isWarning
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle_rounded,
                color: isWarning ? Colors.white : Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: isWarning ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

 static String firebaseErrorMessage(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
