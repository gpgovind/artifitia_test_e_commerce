import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HotSummerSaleSection extends ConsumerWidget {
  const HotSummerSaleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double containerHight =
        ResponsiveHelper.getResponsiveHeight(context, 269);
    final double containerWidth =
        ResponsiveHelper.getResponsiveHeight(context, 200);
    final offer = ref.watch(bannerOfferListProvider);
    return Container(
      height: containerHight,
      //   width: containerWidth,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
        children: [
          Expanded(child: CashImage(image: offer[0].imageUrl)),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Arrivals',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context, 25)),
                  ),
                  Text(
                    "Summer’ 25 Collections",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context, 18)),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        ResponsiveHelper.getResponsiveWidth(context, 20),
                    vertical: ResponsiveHelper.getResponsiveHeight(context, 10),
                  ),
                ),
                child: const Row(
                  children: [
                    Text(
                      'View All',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildSalePerson(Color color) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.person, size: 40, color: Colors.white),
    );
  }
}
