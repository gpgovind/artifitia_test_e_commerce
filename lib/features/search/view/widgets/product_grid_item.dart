import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'product_image.dart';
import 'product_price.dart';
import 'product_rating.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              imageUrl: product.image,
              discountPercent: int.tryParse(product.discount) ?? 0,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ProductRating(
                    rating: double.tryParse(product.rating) ?? 0.0,
                    reviewCount: int.tryParse(product.reviews) ?? 0,
                  ),
                  const SizedBox(height: 8),
                  ProductPrice(
                    price: int.tryParse(product.price) ?? 0,
                    originalPrice: int.tryParse(product.originalPrice) ?? 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
