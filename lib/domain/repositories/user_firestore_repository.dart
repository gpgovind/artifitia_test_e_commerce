import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';
abstract class UserFirestoreRepository {
  Future<void> saveUser(FireStoreUser user);
  Future<FireStoreUser?> getUser(String email);
  Future<void> updateUser(FireStoreUser updates); 
}
