import 'dart:developer';
import 'package:artifitia_test_e_commerce/core/utils/app_warning.dart';
import 'package:artifitia_test_e_commerce/features/onboarding/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = '${dotenv.env['STRIPE_PUBLIC']}';
  log('${dotenv.env['STRIPE_PUBLIC']} ');
  log('${dotenv.env['STRIPE_SECRET']} ');

  await Stripe.instance.applySettings();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
