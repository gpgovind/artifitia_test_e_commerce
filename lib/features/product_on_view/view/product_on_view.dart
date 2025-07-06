import 'package:artifitia_test_e_commerce/domain/entities/product_details.dart';
import 'package:artifitia_test_e_commerce/features/product_on_view/view_model/product_on_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/action_btn_raw.dart';
import 'widgets/delivery_Info.dart';
import 'widgets/price_section.dart';
import 'widgets/product_app_bar.dart';
import 'widgets/product_carousel.dart';
import 'widgets/product_description.dart';
import 'widgets/product_header.dart';
import 'widgets/product_list.dart';
import 'widgets/purchase_btn.dart';
import 'widgets/similar_to.dart';
import 'widgets/size_selection.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductDetails product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(productCarouselCurrentIndexProvider.notifier).state = 0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: ProductAppBar(
        productName: widget.product.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageCarousel(images: widget.product.images),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeSelector(
                    details: widget.product,
                    onSizeSelected: (size) {
                      print('Selected size: $size');
                    },
                  ),
                  const SizedBox(height: 16),
                  ProductHeader(
                    name: widget.product.name,
                    subtitle: widget.product.subtitle,
                    rating: widget.product.rating,
                    reviewCount: widget.product.reviewCount,
                  ),
                  const SizedBox(height: 12),
                  PriceSection(
                    currentPrice: widget.product.currentPrice,
                    originalPrice: widget.product.originalPrice,
                    discountPercent: widget.product.discountPercent,
                  ),
                  const SizedBox(height: 16),
                  ProductDescription(description: widget.product.description),
                  const SizedBox(height: 16),
                  const ActionButtonsRow(),
                  const SizedBox(height: 16),
                  PurchaseButtons(
                    product: widget.product,
                    productName: widget.product.name,
                  ),
                  const SizedBox(height: 16),
                  DeliveryInfo(deliveryTime: widget.product.deliveryTime),
                  const ActionButtonsRow2(),
                  const SizedBox(height: 16),
                  const SimilarTo(),
                  const SizedBox(height: 16),
                  const ProductListing(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
