import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/payment/view/payment_view.dart';
import 'package:artifitia_test_e_commerce/features/payment/view_model/payment_view_model.dart';
import 'package:artifitia_test_e_commerce/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/bottom_summery.dart';
import 'widgets/coupen_section.dart';
import 'widgets/pay_header.dart';
import 'widgets/pay_product_card.dart';
import 'widgets/summery_widget.dart';

class ShoppingBagView extends ConsumerStatefulWidget {
  final ProductDetails product;
  const ShoppingBagView({super.key, required this.product});

  @override
  ConsumerState<ShoppingBagView> createState() => _ShoppingBagViewState();
}

class _ShoppingBagViewState extends ConsumerState<ShoppingBagView> {
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(isQuantityProvider.notifier).state = 1;
        ref.read(isPriceProvider.notifier).state = widget.product.currentPrice;
        ref.read(isFavoriteProvider.notifier).state=false;
      },
    );
  }

  final quantityOptions = List.generate(10, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    final price = ref.watch(isPriceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shopping Bag',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          WishListIcon(
            productName: widget.product.name,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(
                    price: widget.product.currentPrice,
                    imageUrl: widget.product.images.first,
                    title: widget.product.name,
                    subtitle: widget.product.subtitle,
                    size: '42',
                    quantity: quantityOptions,
                    deliveryDate: widget.product.deliveryTime,
                  ),
                  Divider(color: Colors.grey[200]),
                  CouponSection(
                    onSelectCoupon: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Coupon selection opened')),
                      );
                    },
                  ),
                  Divider(color: Colors.grey[200]),
                  const SectionHeader(title: 'Order Payment Details'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        OrderSummaryRow(
                          label: 'Order Amounts',
                          value: '₹ $price',
                        ),
                        OrderSummaryRow(
                          label: 'Convenience',
                          value: 'Apply Coupon',
                          valueColor: Colors.red,
                          actionText: 'Know More',
                          onAction: () {
                            // Handle know more
                          },
                        ),
                        const OrderSummaryRow(
                          label: 'Delivery Fee',
                          value: 'Free',
                          valueColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[200], thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Order Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '₹ $price',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomSummary(
        totalAmount: '₹ $price',
        buttonText: 'Proceed to Payment',
        emiText: 'EMI Available',
        onButtonPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentView(
              product: widget.product,
            ),
          ));
        },
      ),
    );
  }
}

class WishListIcon extends ConsumerWidget {
  final String productName;
  const WishListIcon({super.key, required this.productName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider);
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        ref.read(wishListViewModelProvider.notifier).addToWishList(productName);
        ref.read(isFavoriteProvider.notifier).state = !isFavorite;
      },
    );
  }
}
