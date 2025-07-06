import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/product_card.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view/product_on_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListing extends ConsumerStatefulWidget {
  const ProductListing({super.key});

  @override
  ConsumerState<ProductListing> createState() => _ProductBuilderState();
}

class _ProductBuilderState extends ConsumerState<ProductListing> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              final data = ProductDetails(
                id: product.title,
                name: product.title,
                category: product.category,
                subtitle: product.description,
                images: [product.image, product.image, product.image],
                currentPrice: int.tryParse(product.price) ?? 0,
                originalPrice: int.tryParse(product.originalPrice) ?? 0,
                discountPercent: int.tryParse(product.discount) ?? 0,
                rating: double.tryParse(product.rating) ?? 0.0,
                reviewCount: int.tryParse(product.reviews) ?? 0,
                sizes: product.size,
                selectedSize: product.size.isNotEmpty ? product.size.first : '',
                description: product.details,
                deliveryTime: "3-5 days",
              );

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: data),
              ));
            },
            child: ProductCard(
              hidRating: false,
              image: product.image,
              title: product.title,
              subtitle: product.description,
              price: '\$${product.price}',
              originalPrice: '\$${product.originalPrice}',
              discount: '${product.discount}% OFF',
              rating: double.parse(product.rating),
              reviews: int.parse(product.reviews),
            ),
          );
        },
      ),
    );
  }
}
