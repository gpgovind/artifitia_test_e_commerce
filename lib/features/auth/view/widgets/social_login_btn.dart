import 'package:artifitia_test_e_commerce/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialLoginButtons extends ConsumerWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onFacebookPressed;

  const SocialLoginButtons({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onFacebookPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGoogleSign = ref.watch(googleSignProvider);
    return Column(
      children: [
        Text(
          '- OR Continue with -',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGoogleSign.isLoading
                ? const CircularProgressIndicator()
                : _buildSocialButton(
                    onPressed: onGooglePressed,
                    child: const Text('G',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
            const SizedBox(width: 16),
            _buildSocialButton(
              onPressed: onApplePressed,
              child: const Icon(Icons.apple, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              onPressed: onFacebookPressed,
              child: const Text('f',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      {required VoidCallback onPressed, required Widget child}) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: child,
      ),
    );
  }
}
