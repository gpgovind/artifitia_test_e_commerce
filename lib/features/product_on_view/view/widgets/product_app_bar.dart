import 'package:artifitia_test_e_commerce/features/cart_list/view_model/cart_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String productName;
  const ProductAppBar({super.key, required this.productName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cartListViewModelProvider);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: controller.isLoading
              ? const CircularProgressIndicator()
              : const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {
            ref
                .read(cartListViewModelProvider.notifier)
                .addToCartList(productName);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
