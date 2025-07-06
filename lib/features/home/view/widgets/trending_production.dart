import 'package:flutter/material.dart';

import 'product_card.dart';
import 'section_head.dart';

class TrendingProductsSection extends StatelessWidget {
  const TrendingProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionHeader(
            color: Colors.pink.shade400,
            title: 'Trending Products',
            subtitle: '📅 Last Date 29/02/22',
            showViewAll: true,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
