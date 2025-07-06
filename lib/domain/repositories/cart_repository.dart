
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';

abstract class CartRepository {
  Future<bool> saveToCartList(
      {required String email, required String productName});
  Future<List<Product>> getCartList({required String email});
}
