import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color color;
  final bool showViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.color,
    this.subtitle,
    this.showViewAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.white,
                )),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'View all →',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
