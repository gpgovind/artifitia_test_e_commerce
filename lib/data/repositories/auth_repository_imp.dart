import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/utils/app_warning.dart';
import 'package:artifitia_test_e_commerce/domain/entities/user.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final fb.FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<UserInt?> login(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? firebaseUser = result.user;
      if (firebaseUser != null) {
        return UserInt(uid: firebaseUser.uid, email: firebaseUser.email);
      }
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(AppWarning.firebaseErrorMessage(e));
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong. Try again.");
    }
    return null;
  }

  @override
  Future<UserInt?> signup({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? firebaseUser = result.user;
      if (firebaseUser != null) {
        return UserInt(uid: firebaseUser.uid, email: firebaseUser.email);
      }
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(AppWarning.firebaseErrorMessage(e));
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong during signup.");
    }
    return null;
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserCredential?> googleSign() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        return null;
      } else {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userData = await _firebaseAuth.signInWithCredential(credential);
        return userData;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  // @override
  // Future<UserCredential?> facebookSign() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   try {
  //     if (result.status == LoginStatus.success) {
  //       final accessToken = result.accessToken;
  //       final facebookAuthCredential =
  //           FacebookAuthProvider.credential(accessToken!.tokenString);
  //       return await FirebaseAuth.instance
  //           .signInWithCredential(facebookAuthCredential);
  //     } else {
  //       log('Facebook login failed: ${result.message}');
  //       return null;
  //     }
  //   } catch (e) {
  //     log('Facebook login error: $e');
  //     return null;
  //   }
  // }
}
