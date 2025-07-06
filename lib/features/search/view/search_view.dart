import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/cart_list/view_model/cart_list_view_model.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view/product_on_view.dart';
import 'package:artifitia_test_e_commerce/features/search/view/widgets/search_appbar.dart';
import 'package:artifitia_test_e_commerce/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'widgets/product_grid_item.dart';
import 'widgets/result_header.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: SearchAppBar(
        searchController: TextEditingController(),
        onSearchChanged: (query) {},
      ),
      body: Column(
        children: [
          const ResultsHeader(itemCount: 52062),
          Expanded(
            child: TrendingProductsGrid(
              products: products,
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingProductsGrid extends ConsumerWidget {
  final List<Product> products;
  final bool isCart;
  final bool isSearch;
  final bool isWishList;

  const TrendingProductsGrid({
    super.key,
    required this.products,
    this.isCart = false,
    this.isSearch = false,
    this.isWishList = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        if (isCart) {
          ref.read(cartListViewModelProvider.notifier).getCartList();
        }
        if (isWishList) {
          ref.read(wishListViewModelProvider.notifier).getWishList();
        }
      },
      child: MasonryGridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductGridItem(
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
            product: product,
          );
        },
      ),
    );
  }
}
