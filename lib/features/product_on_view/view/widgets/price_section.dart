import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  final int currentPrice;
  final int originalPrice;
  final int discountPercent;

  const PriceSection({
    super.key,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Text(
          '₹$originalPrice',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
            decoration: TextDecoration.lineThrough,
          ),
        ),
      
        const SizedBox(width: 12),
         Text(
          '₹$currentPrice',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$discountPercent% off',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}


