import 'package:flutter/material.dart';

import 'create_account_view.dart';
import 'forget_password_view.dart';
import 'login_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String currentScreen = 'login';

  void navigateToScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreen) {
      case 'signup':
        return SignupScreen(onNavigate: navigateToScreen);
      case 'forgot':
        return ForgotPasswordScreen(onNavigate: navigateToScreen);
      default:
        return LoginScreen(onNavigate: navigateToScreen);
    }
  }
}
