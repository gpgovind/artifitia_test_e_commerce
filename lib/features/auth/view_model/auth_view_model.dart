import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/core/utils/app_warning.dart';
import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  FutureOr<void> build() {}

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final localRepo = await ref.read(sharedPrefHelperProvider.future);
      final user = await repo.login(email, password);
      if (user != null) {
        await localRepo.saveUser(email: email);
        state = const AsyncData(null);
        return true;
      }
      return false;
    } catch (e, st) {
      AppWarning.showWarning(e.toString());
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> signup({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.signup(email: email, password: password);
      final localRepo = await ref.read(sharedPrefHelperProvider.future);
      final firestore = ref.read(userFirestoreRepoProvider);

      if (user != null) {
        await firestore.saveUser(FireStoreUser(email: email, isNewUser: true));
        await localRepo.saveUser(
          email: email,
        );

        state = const AsyncData(null);
        return true;
      }
    } catch (e, st) {
      AppWarning.showWarning(e.toString());
      state = AsyncError(e, st);
    }
    return false;
  }

  Future<void> forgotPassword(String email) async {
    try {
      final repo = ref.read(authRepositoryProvider);
      final isOtp = await repo.sendPasswordResetEmail(email);

      if (isOtp) {
        await Future.delayed(const Duration(seconds: 3));
        AppWarning.showWarning(
            'Otp has sended successfully please check your email', false);
      } else {
        AppWarning.showWarning(
          'fail to send otp',
        );
      }
    } catch (e) {
      log('Error sending reset email: $e');
    }
  }
}

@riverpod
class GoogleSign extends _$GoogleSign {
  @override
  FutureOr<void> build() {}
  Future<void> googleSign() async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.googleSign();
      final localRepo = await ref.read(sharedPrefHelperProvider.future);
      final firestore = ref.read(userFirestoreRepoProvider);

      if (user != null) {
        await firestore.saveUser(
            FireStoreUser(email: user.user!.email!, isNewUser: false));
        await localRepo.saveUser(
          email: user.user!.email!,
        );

        state = const AsyncData(null);
      } else {
        state = AsyncError('Google sign-in failed', StackTrace.current);
      }
    } catch (e, st) {
      AppWarning.showWarning(e.toString());
      state = AsyncError(e, st);
    }
  }
}


  // Future<void> facebookSign() async {
  //   state = const AsyncLoading();
  //   try {
  //     final repo = ref.read(authRepositoryProvider);
  //     final user = await repo.facebookSign();
  //     final localRepo = await ref.read(sharedPrefHelperProvider.future);
  //     final firestore = ref.read(userFirestoreRepoProvider);

  //     if (user != null) {
  //       await firestore.saveUser(
  //           FireStoreUser(email: user.user!.email!, isNewUser: false));
  //       await localRepo.saveUser(
  //         email: user.user!.email!,
  //       );

  //       state = const AsyncData(null);
  //     }
  //   } catch (e, st) {
  //     AppWarning.showWarning(e.toString());
  //     state = AsyncError(e, st);
  //   }
  // }





