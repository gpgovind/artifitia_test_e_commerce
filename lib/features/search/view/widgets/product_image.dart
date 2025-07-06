import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final int discountPercent;

  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.getResponsiveHeight(context, 120),
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: CashImage(image: imageUrl)),
        ],
      ),
    );
  }
}
