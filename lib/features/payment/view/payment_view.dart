import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/payment/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentView extends ConsumerWidget {
  final ProductDetails product;
  const PaymentView({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentIsLoading = ref.watch(paymentViewModelProvider).isLoading;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Check Out'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Order'),
            trailing: Text('₹ ${product.currentPrice}'),
          ),
          const ListTile(
            title: Text('Shipping'),
            trailing: Text('₹ 30'),
          ),
          ListTile(
            title: const Text('Shipping'),
            trailing: Text('₹ ${product.currentPrice + 30}'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Payment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stripe',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '********',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.apple_outlined),
                Text(
                  '********',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (!paymentIsLoading) {
                ref
                    .read(paymentViewModelProvider.notifier)
                    .makePayment(product.currentPrice, 'USD');
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  paymentIsLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
