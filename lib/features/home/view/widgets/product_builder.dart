import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view/product_on_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_card.dart';

class ProductBuilder extends ConsumerStatefulWidget {
  final bool hidRating;
  final bool inReverse;

  const ProductBuilder(
      {super.key, this.hidRating = false, this.inReverse = false});

  @override
  ConsumerState<ProductBuilder> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends ConsumerState<ProductBuilder> {
  final ScrollController _scrollController = ScrollController();

  void _scrollForward() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    final double containerHeight =
        ResponsiveHelper.getResponsiveHeight(context, 260);

    return Container(
      height: containerHeight,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 48),
            child: Row(
              children: List.generate(products.length, (index) {
                final reversed = products.reversed.toList();
                final product =
                    widget.inReverse ? reversed[index] : products[index];
                return GestureDetector(
                  onTap: () {
                    final data = ProductDetails(
                      id: product.title,
                      name: product.title,
                      category: product.category,
                      subtitle: product.description,
                      images: [product.image,product.image,product.image],
                      currentPrice: int.tryParse(product.price) ?? 0,
                      originalPrice: int.tryParse(product.originalPrice) ?? 0,
                      discountPercent: int.tryParse(product.discount) ?? 0,
                      rating: double.tryParse(product.rating) ?? 0.0,
                      reviewCount: int.tryParse(product.reviews) ?? 0,
                      sizes: product.size,
                      selectedSize:
                          product.size.isNotEmpty ? product.size.first : '',
                      description: product.details,
                      deliveryTime: "3-5 days",
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: data,
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: ProductCard(
                      hidRating: widget.hidRating,
                      image: product.image,
                      title: product.title,
                      subtitle: product.description,
                      price: '\$${product.price}',
                      originalPrice: '\$${product.originalPrice}',
                      discount: '${product.discount}% OFF',
                      rating: double.parse(product.rating),
                      reviews: int.parse(product.reviews),
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onPressed: _scrollForward,
                ),
              )),
        ],
      ),
    );
  }
}
