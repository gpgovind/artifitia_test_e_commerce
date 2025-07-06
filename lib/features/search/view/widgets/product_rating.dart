import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ProductRating({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
          unratedColor: Colors.grey[300],
          direction: Axis.horizontal,
        ),
        const SizedBox(width: 4),
        Text(
          '$rating ($reviewCount)',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
