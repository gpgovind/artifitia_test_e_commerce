import 'package:artifitia_test_e_commerce/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  
}
