import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final double rating;
  final int reviewCount;

  const ProductHeader({
    super.key,
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
              unratedColor: Colors.grey[300],
              direction: Axis.horizontal,
            ),
            const SizedBox(width: 8),
            Text(
              '$rating ($reviewCount)',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
