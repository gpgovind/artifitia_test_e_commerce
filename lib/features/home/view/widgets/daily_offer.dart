import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_card.dart';
import 'section_head.dart';

class DealOfTheDaySection extends ConsumerWidget {
  const DealOfTheDaySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    return Container(
      margin: const EdgeInsets.all(16),
      child: const Column(
        children: [
          SectionHeader(
            color: Colors.blue,
            title: 'Deal of the Day',
            subtitle: '⏰ 22h 55m 20s remaining',
            showViewAll: true,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
