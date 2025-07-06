import 'package:artifitia_test_e_commerce/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/custom_btn.dart';
import 'widgets/custom_texfiled.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  final Function(String) onNavigate;

  const ForgotPasswordScreen({super.key, required this.onNavigate});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authViewModelProvider.notifier)
          .forgotPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOtp = ref.watch(authViewModelProvider).isLoading;
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
                  'Forgot\npassword?',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  hintText: 'Enter your email address',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  '* We will send you a message to set or reset your new password',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Submit',
                  onPressed: _handleSubmit,
                  isLoading: isOtp,
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () => widget.onNavigate('login'),
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
