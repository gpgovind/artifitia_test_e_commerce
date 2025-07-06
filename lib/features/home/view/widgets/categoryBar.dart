import 'dart:developer';

import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category_circle.dart';
import 'search_bar.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(bannerListProvider);
    log(controller.length.toString());
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBarNew(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Featured',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sort),
                    label: const Text('Sort'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: controller.toList().map((category) {
              return CategoryCircle(
                name: category.category,
                image: category.imageUrl,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
