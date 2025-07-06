import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final int price;
  final int originalPrice;

  const ProductPrice({
    super.key,
    required this.price,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '₹$price',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (originalPrice > price)
          Text(
            '₹$originalPrice',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}
