import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String originalPrice;
  final String discount;
  final double rating;
  final int reviews;
  final bool hidRating;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    this.hidRating = false,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFontSize =
        ResponsiveHelper.getResponsiveFontSize(context, 14);
    final double subtitleFontSize =
        ResponsiveHelper.getResponsiveFontSize(context, 10);
    final double priceFontSize =
        ResponsiveHelper.getResponsiveFontSize(context, 14);
    final double originalPriceFontSize =
        ResponsiveHelper.getResponsiveFontSize(context, 12);
    final double reviewFontSize =
        ResponsiveHelper.getResponsiveFontSize(context, 10);

    final double imageHeight =
        ResponsiveHelper.getResponsiveHeight(context, 100);
    final EdgeInsets padding = ResponsiveHelper.getResponsivePadding(context);
    final double containerHight =
        ResponsiveHelper.getResponsiveHeight(context, 269);
    final double containerWidth =
        ResponsiveHelper.getResponsiveHeight(context, 200);
    return Container(
      height: hidRating ? containerHight - 50 : containerHight,
      width: containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imageHeight,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child:
                  image.isNotEmpty ? CashImage(image: image) : const SizedBox(),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: priceFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontSize: originalPriceFontSize,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      discount,
                      style: TextStyle(
                        fontSize: originalPriceFontSize,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                hidRating
                    ? const SizedBox()
                    : Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 2),
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: ResponsiveHelper.getResponsiveFontSize(
                                context, 14),
                            unratedColor: Colors.grey[300],
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '($reviews)',
                            style: TextStyle(
                              fontSize: reviewFontSize,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
