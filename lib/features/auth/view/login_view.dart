import 'package:artifitia_test_e_commerce/features/auth/view_model/auth_view_model.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/custom_btn.dart';
import 'widgets/custom_texfiled.dart';
import 'widgets/social_login_btn.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final Function(String) onNavigate;

  const LoginScreen({super.key, required this.onNavigate});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final isDone = await ref
          .read(authViewModelProvider.notifier)
          .login(_emailController.text, _passwordController.text);

      if (mounted && isDone) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomBavCt()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginRepo = ref.watch(authViewModelProvider);
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
                  'Welcome\nBack!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  hintText: 'Username or Email',
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
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => widget.onNavigate('forgot'),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Login',
                  onPressed: _handleLogin,
                  isLoading: loginRepo.isLoading,
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
                      'Create An Account ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.onNavigate('signup'),
                      child: const Text(
                        'Sign Up',
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
