import 'package:artifitia_test_e_commerce/features/auth/view_model/auth_view_model.dart';
import 'package:artifitia_test_e_commerce/features/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/custom_btn.dart';
import 'widgets/custom_texfiled.dart';
import 'widgets/social_login_btn.dart';

class SignupScreen extends ConsumerStatefulWidget {
  final Function(String) onNavigate;

  const SignupScreen({super.key, required this.onNavigate});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSign() async {
    if (_formKey.currentState!.validate()) {
      final isDone = await ref.read(authViewModelProvider.notifier).signup(
          email: _emailController.text, password: _passwordController.text);

      if (isDone) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSign = ref.watch(authViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Create an\naccount',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  hintText: 'Email',
                  prefixIcon: Icons.person_outline,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: 'By clicking the ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    children: [
                      const TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: ' button, you agree to the public offer',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Create Account',
                  onPressed: _handleSign,
                  isLoading: isSign.isLoading,
                ),
                const SizedBox(height: 40),
                SocialLoginButtons(
                  onGooglePressed: () {
                    ref.read(googleSignProvider.notifier).googleSign();
                  },
                  onApplePressed: () => print('Apple login'),
                  onFacebookPressed: () => print('Apple login'),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I Already Have an Account ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.onNavigate('login'),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
