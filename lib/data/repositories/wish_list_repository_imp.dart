import 'package:artifitia_test_e_commerce/data/models/product_model.dart';
import 'package:artifitia_test_e_commerce/domain/entities/product.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/wish_list_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishListRepositoryImp implements WishListRepository {
  final FirebaseFirestore _firestore;
  WishListRepositoryImp(this._firestore);

  @override
  Future<List<Product>> getWishList({required String email}) async {
    final wishDoc = await _firestore.collection('wishList').doc(email).get();

    if (!wishDoc.exists) return [];

    final productIds = List<String>.from(wishDoc.data()?['productIds'] ?? []);
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
  Future<bool> saveToWishList({
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

      final wishDoc = await _firestore.collection('wishList').doc(email).get();

      List<String> currentWishList = [];

      if (wishDoc.exists) {
        final data = wishDoc.data();
        currentWishList = List<String>.from(data?['productIds'] ?? []);
      }

      if (currentWishList.contains(docId)) {
        return false;
      }

      currentWishList.add(docId);

      await _firestore.collection('wishList').doc(email).set({
        'productIds': currentWishList,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
