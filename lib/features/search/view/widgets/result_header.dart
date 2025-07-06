
import 'package:flutter/material.dart';
import 'filter_btn.dart';

class ResultsHeader extends StatelessWidget {
  final int itemCount;

  const ResultsHeader({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trending Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${itemCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} items',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              FilterButton(
                icon: Icons.sort,
                label: 'Sort',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              FilterButton(
                icon: Icons.filter_alt_outlined,
                label: 'Filter',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
