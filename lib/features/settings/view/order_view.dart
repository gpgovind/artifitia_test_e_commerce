import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white, title: const Text('Order View')),
      body: const Center(child: Text('Order details go here')),
    );
  }
}
