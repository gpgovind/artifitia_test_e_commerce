import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/cart_list/view_model/cart_list_view_model.dart';
import 'package:artifitia_test_e_commerce/features/payment/view/shopping_bag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseButtons extends ConsumerWidget {
  final String productName;
  final ProductDetails product;
  const PurchaseButtons(
      {super.key, required this.productName, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = ResponsiveHelper.getResponsiveWidth(context, 160);
    final hight = ResponsiveHelper.getResponsiveHeight(context, 60);
    final widthIn = ResponsiveHelper.getResponsiveWidth(context, 120);
    final hightIN = ResponsiveHelper.getResponsiveHeight(context, 50);
    final controller = ref.watch(cartListViewModelProvider);
    return Row(
      children: [
        controller.isLoading
            ? const CircularProgressIndicator()
            : cstBtn(
                width,
                hight,
                widthIn,
                hightIN,
                () {
                  ref
                      .read(cartListViewModelProvider.notifier)
                      .addToCartList(productName);
                },
                Colors.blueAccent,
                Icons.shopping_cart,
                'Go to cart',
                context,
              ),
        SizedBox(
          width: ResponsiveHelper.getResponsiveWidth(context, 20),
        ),
        cstBtn(
          width,
          hight,
          widthIn,
          hightIN,
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingBagView(
                    product: product,
                  ),
                ));
          },
          Colors.greenAccent,
          Icons.touch_app,
          'Buy Now',
          context,
        ),
      ],
    );
  }

  cstBtn(
      double width,
      double hight,
      double widthIn,
      double hightIN,
      void Function()? onTap,
      Color color,
      IconData icon,
      String text,
      BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        //  color: Colors.red,
        width: width,
        height: hight,

        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: widthIn,
                height: hightIN,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                    radius: ResponsiveHelper.getResponsiveFontSize(context, 30),
                    backgroundColor: color,
                    child: Icon(
                      icon,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
