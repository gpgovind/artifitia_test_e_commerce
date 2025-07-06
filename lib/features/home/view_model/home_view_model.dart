import 'dart:developer';
import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/domain/entities/banner.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_view_model.g.dart';



final bannerListProvider = StateProvider<List<BannerModel>>((ref) => []);
final bannerOfferListProvider = StateProvider<List<BannerModel>>((ref) => []);
final productListProvider = StateProvider<List<Product>>((ref) => []);

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> getBanners() async {
    final repo = ref.read(bannerFirestoreRepoProvider);
    final data = await repo.getBanners();
    ref.read(bannerListProvider.notifier).update((current) => [
          ...current,
          ...data,
        ]);
  }

  Future<void> getOfferBanners() async {
    final repo = ref.read(bannerFirestoreRepoProvider);
    final data = await repo.getOfferBanners();
    ref.read(bannerOfferListProvider.notifier).update((current) => [
          ...current,
          ...data,
        ]);
  }

  Future<void> getProducts() async {
    final repo = ref.read(productFirestoreRepoProvider);
    final data = await repo.getProducts();
    ref.read(productListProvider.notifier).update((current) => [
          ...current,
          ...data,
        ]);
  }
}
