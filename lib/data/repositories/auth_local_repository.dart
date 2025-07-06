import 'package:artifitia_test_e_commerce/core/utils/shared_pref_helper.dart';
import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/user_local_repository.dart';

class AuthLocalRepository implements UserLocalRepository {
  final SharedPrefHelper _helper;

  AuthLocalRepository(this._helper);

  @override
  Future<void> saveUser(FireStoreUser user) async {
    await _helper.saveUser(email: user.email);
  }

  @override
  FireStoreUser? getUser() {
    final email = _helper.userEmail;
    if (email != null) {
      return FireStoreUser(email: email);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _helper.clearUser();
  }
}
