import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SponsoredSection extends ConsumerWidget {
  const SponsoredSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double containerHight =
        ResponsiveHelper.getResponsiveHeight(context, 280);

    final offer = ref.watch(bannerOfferListProvider);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: containerHight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sponsored',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: CashImage(image: offer[3].imageUrl),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'up to 50% Off',
                style: TextStyle(
                    fontSize:
                        ResponsiveHelper.getResponsiveFontSize(context, 18),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: ResponsiveHelper.getResponsiveFontSize(context, 18),
              )
            ],
          ),
        ],
      ),
    );
  }
}
