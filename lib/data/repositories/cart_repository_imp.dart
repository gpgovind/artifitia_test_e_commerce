import 'package:artifitia_test_e_commerce/data/models/product_model.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartRepositoryImp implements CartRepository {
  final FirebaseFirestore _firestore;

  CartRepositoryImp(this._firestore);

  @override
  Future<List<Product>> getCartList({required String email}) async {
    final cartDoc = await _firestore.collection('Cart').doc(email).get();

    if (!cartDoc.exists) return [];

    final productIds = List<String>.from(cartDoc.data()?['productIds'] ?? []);
    if (productIds.isEmpty) return [];

    final querySnapshot = await _firestore
        .collection('products')
        .where(FieldPath.documentId, whereIn: productIds)
        .get();

    final list = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return ProductModel.fromJson(data);
    }).toList();

    final data = list
        .map(
          (e) => e.toEntity(),
        )
        .toList();

    return data;
  }

  @override
  Future<bool> saveToCartList({
    required String email,
    required String productName,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('title', isEqualTo: productName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      final doc = querySnapshot.docs.first;
      final docId = doc.id;

      final cartDoc = await _firestore.collection('Cart').doc(email).get();

      List<String> currentCart = [];

      if (cartDoc.exists) {
        final data = cartDoc.data();
        currentCart = List<String>.from(data?['productIds'] ?? []);
      }

      if (currentCart.contains(docId)) {
        return false;
      }

      currentCart.add(docId);

      await _firestore.collection('Cart').doc(email).set({
        'productIds': currentCart,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
