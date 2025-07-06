import 'package:artifitia_test_e_commerce/core/utils/app_image_util.dart';
import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlatHeelsSection extends ConsumerWidget {
  const FlatHeelsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ref.watch(bannerOfferListProvider);

    final double postion = ResponsiveHelper.getResponsiveWidth(context, 60);
    final double imageBoxSize =
        ResponsiveHelper.getResponsiveWidth(context, 100);
    final double containerSize =
        ResponsiveHelper.getResponsiveWidth(context, 140);
    final double fontTitle =
        ResponsiveHelper.getResponsiveFontSize(context, 16);
    final double fontSubtitle =
        ResponsiveHelper.getResponsiveFontSize(context, 12);
    final EdgeInsets padding = ResponsiveHelper.getResponsivePadding(context);

    return Container(
      margin: padding,
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
      child: Stack(
        children: [
          Container(
            color: Colors.blue[50],
            //  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Flat and Heels',
                              style: TextStyle(
                                fontSize: fontTitle,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Stand a chance to get rewarded',
                              style: TextStyle(
                                fontSize: fontSubtitle,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ResponsiveHelper.getResponsiveWidth(
                                          context, 20),
                                  vertical:
                                      ResponsiveHelper.getResponsiveHeight(
                                          context, 10),
                                ),
                              ),
                              child: Text(
                                'Visit now',
                                style: TextStyle(fontSize: fontSubtitle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: postion,
                  bottom: 10,
                  top: 10,
                  child: SizedBox(
                    height: imageBoxSize,
                    width: imageBoxSize,
                    child: offer.isNotEmpty
                        ? CashImage(image: offer[4].imageUrl)
                        : const SizedBox(),
                  ),
                ),
                Container(
                    width: containerSize - 30,
                    height: containerSize,
                    decoration: const BoxDecoration(
                      // color: Colors.yellow[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Image.asset(AppImageUtil.particles)),
              ],
            ),
          ),
          Container(
            width: 20,
            height: containerSize,
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
