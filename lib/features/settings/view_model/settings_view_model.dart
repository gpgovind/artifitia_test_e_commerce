import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/core/utils/app_warning.dart';
import 'package:artifitia_test_e_commerce/domain/entities/address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings_view_model.g.dart';

final addressTextEditingControllerProvider =
    StateProvider<List<TextEditingController>>((ref) => List.generate(
          8,
          (index) => TextEditingController(),
        ));

final stateProvider = StateProvider<String>((ref) => 'N1 2LL');
final countryProvider = StateProvider<String>((ref) => 'India');

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> saveAddress({required Address address}) async {
    final repo = ref.read(addressRepoProvider);
    final isSaved = await repo.saveAddress(address: address);

    if (isSaved) {
      state = const AsyncData(null);
      AppWarning.showWarning('Added to cart', false);
    } else {
      state = AsyncError('Failed to save to cart', StackTrace.current);
      AppWarning.showWarning('Failed to save');
    }
  }

  Future<bool> logout() async {
    final googleSignIn = GoogleSignIn();

    try {
      await FirebaseAuth.instance.signOut();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();

        try {
          await googleSignIn.disconnect();
        } catch (e) {
          log('Google disconnect skipped: $e');
        }
      }

      final sharedPre = await ref.read(sharedPrefHelperProvider.future);
      sharedPre.clearUser();
      return true;
    } catch (e) {
      log('Logout failed: $e');
      return false;
    }
  }
}

@riverpod
class GetAddress extends _$GetAddress {
  @override
  FutureOr<Address?> build() async {
    final repo = ref.read(addressRepoProvider);
    final user = await ref.read(sharedPrefHelperProvider.future);
    final data = await repo.getAddress(email: user.userEmail ?? "");
    return data;
  }
}
