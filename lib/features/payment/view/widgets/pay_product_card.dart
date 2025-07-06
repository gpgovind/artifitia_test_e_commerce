import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/payment/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String size;
  final int price;
  final List<int> quantity;
  final String deliveryDate;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.size,
    required this.quantity,
    required this.deliveryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ResponsiveHelper.getResponsiveWidth(context, 100),
            height: ResponsiveHelper.getResponsiveHeight(context, 120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Size $size',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 12, vertical: 8),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey[300]!),
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Qty $quantity',
                    //         style: const TextStyle(fontSize: 14),
                    //       ),
                    //       const SizedBox(width: 8),
                    //       Icon(
                    //         Icons.keyboard_arrow_down,
                    //         size: 16,
                    //         color: Colors.grey[600],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    QuantityDropdown(
                      quantityOptions: quantity,
                      price: price,
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Delivery by $deliveryDate',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityDropdown extends ConsumerWidget {
  final List<int> quantityOptions;
  final int price;
  const QuantityDropdown(
      {super.key, required this.quantityOptions, required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(isQuantityProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: quantity,
          elevation: 0,
          icon: Icon(Icons.keyboard_arrow_down,
              size: 16, color: Colors.grey[600]),
          items: quantityOptions
              .map((q) => DropdownMenuItem<int>(
                    value: q,
                    child: Text('Qty $q', style: const TextStyle(fontSize: 14)),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              ref.read(isQuantityProvider.notifier).state = value;
              final totalPrice = price * value;
              ref.read(isPriceProvider.notifier).state = totalPrice;
            }
          },
        ),
      ),
    );
  }
}
