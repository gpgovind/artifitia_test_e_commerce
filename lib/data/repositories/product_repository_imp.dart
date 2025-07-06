import 'package:artifitia_test_e_commerce/data/models/product_model.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepositoryImp implements ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepositoryImp(this._firestore);

  @override
  Future<List<Product>> getProducts() async {
    final querySnapshot = await _firestore.collection('products').get();
    final list = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return ProductModel.fromJson(data);
    }).toList();

   final data= list.map((e) => e.toEntity(),).toList();

    return data;
  }
}
