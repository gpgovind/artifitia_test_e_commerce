import 'package:artifitia_test_e_commerce/domain/entities/product.dart';

abstract class WishListRepository {
  Future<bool> saveToWishList(
      {required String email, required String productName});
  Future<List<Product>> getWishList({required String email});
}
