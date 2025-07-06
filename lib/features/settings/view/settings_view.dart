import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/features/onboarding/view/splash_view.dart';
import 'package:artifitia_test_e_commerce/features/settings/view_model/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'address_view.dart';
import 'order_view.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SettingsButton(
              title: 'Order View',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderView()),
                );
              },
            ),
            const SizedBox(height: 16),
            SettingsButton(
              title: 'Address View',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddressView()),
                );
              },
            ),
            SettingsButton(
              title: 'Log Out',
              onPressed: () {
                showLogoutDialog(
                  context,
                  () async {
                    final logOut = await ref
                        .read(settingsViewModelProvider.notifier)
                        .logout();
                    if (logOut ) {
                     if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const SplashScreen()),
                        (route) => false,
                      );
                     }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onPressed,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

Future<void> showLogoutDialog(
    BuildContext context, VoidCallback onConfirm) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
