import 'package:artifitia_test_e_commerce/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserInt?> login(String email, String password);
  Future<UserInt?> signup({
    required String email,
    required String password,
  });
  Future<bool> sendPasswordResetEmail(String email);
  Future<UserCredential?> googleSign();
  // Future<UserCredential?> facebookSign();
}
