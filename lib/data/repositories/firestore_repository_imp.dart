import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/user_firestore_repository.dart';

class FirestoreRepositoryImpl implements UserFirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepositoryImpl(this._firestore);

  @override
  Future<void> saveUser(FireStoreUser user) async {
    final docId = user.email.replaceAll('.', '_');
    final docRef = _firestore.collection('users').doc(docId);

    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set(user.toJson());
    }
  }

  @override
  Future<FireStoreUser?> getUser(String email) async {
    final docId = email.replaceAll('.', '_');
    if (docId.isEmpty) {
      return null;
    }
    final doc = await _firestore.collection('users').doc(docId).get();
    if (doc.exists) {
      return FireStoreUser.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> updateUser(FireStoreUser updates) async {
    final docId = updates.email.replaceAll('.', '_');
    await _firestore.collection('users').doc(docId).update(updates.toJson());
  }
}
