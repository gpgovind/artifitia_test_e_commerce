import 'package:artifitia_test_e_commerce/features/cart_list/view_model/cart_list_view_model.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/top_bar.dart';
import 'package:artifitia_test_e_commerce/features/home/view_model/home_view_model.dart';
import 'package:artifitia_test_e_commerce/features/wish_list/view_model/wish_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/categoryBar.dart';
import 'widgets/daily_offer.dart';
import 'widgets/flatt_heel.dart';
import 'widgets/hot_summer.dart';
import 'widgets/nav_bar.dart';
import 'widgets/product_builder.dart';
import 'widgets/promo_bar.dart';
import 'widgets/special_offer_section.dart';
import 'widgets/sponserd_section.dart';
import 'widgets/trending_production.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    _initialize();
    super.initState();
  }

  _initialize() {
    ref.read(homeViewModelProvider.notifier).getBanners();
    ref.read(homeViewModelProvider.notifier).getOfferBanners();
    ref.read(homeViewModelProvider.notifier).getProducts();
    ref.read(cartListViewModelProvider.notifier).getCartList();
    ref.read(wishListViewModelProvider.notifier).getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CategorySection(),
            CarouselCard(),
            DealOfTheDaySection(),
            ProductBuilder(),
            SpecialOffersSection(),
            FlatHeelsSection(),
            TrendingProductsSection(),
            ProductBuilder(
              hidRating: true,
              inReverse: true,
            ),
            HotSummerSaleSection(),
            SponsoredSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
