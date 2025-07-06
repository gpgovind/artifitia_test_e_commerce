import 'package:artifitia_test_e_commerce/features/home/view/widgets/cash_image.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view_model/product_on_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductImageCarousel extends ConsumerWidget {
  final List<String> images;

  ProductImageCarousel({super.key, required this.images});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(productCarouselCurrentIndexProvider);
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              ref.read(productCarouselCurrentIndexProvider.notifier).state =
                  index;
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CashImage(image: images[index])),
              );
            },
          ),
          Positioned(
            right: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < images.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        currentIndex == index ? Colors.blue : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
