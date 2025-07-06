import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/features/search/view/search_view.dart';
import 'package:artifitia_test_e_commerce/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListView extends ConsumerWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishList = ref.watch(wishListProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Wish List'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(wishListViewModelProvider.notifier).getWishList();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          wishList.isEmpty
              ? const Center(
                  child: Text(
                    '🛍️ Your wishlist is empty!\nStart adding your favorite items.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Expanded(
                  child: TrendingProductsGrid(
                    products: wishList,
                    isWishList: true,
                  ),
                )
        ],
      ),
    );
  }
}
