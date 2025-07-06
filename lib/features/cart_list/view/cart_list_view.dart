import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/features/cart_list/view_model/cart_list_view_model.dart';
import 'package:artifitia_test_e_commerce/features/search/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListView extends ConsumerWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartListProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ref.read(cartListViewModelProvider.notifier).getCartList();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
        backgroundColor: AppColors.white,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cart.isEmpty
              ? const Center(
                  child: Text(
                    '🛍️ Your wishlist is empty!\nStart adding your favorite items.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Expanded(
                  child: TrendingProductsGrid(
                    products: cart,
                    isCart: true,
                  ),
                )
        ],
      ),
    );
  }
}
