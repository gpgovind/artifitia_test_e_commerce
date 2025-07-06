import 'package:artifitia_test_e_commerce/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<List<BannerModel>> getBanners();
  Future<List<BannerModel>> getOfferBanners();
}
