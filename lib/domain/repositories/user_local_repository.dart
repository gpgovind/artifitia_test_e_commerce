import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';

abstract class UserLocalRepository {
  Future<void> saveUser(FireStoreUser user);
  FireStoreUser? getUser();
  Future<void> logout();
}
