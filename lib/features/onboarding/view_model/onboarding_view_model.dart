import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:artifitia_test_e_commerce/core/utils/app_image_util.dart';
import 'package:artifitia_test_e_commerce/domain/entities/onboarding.dart';
import 'package:artifitia_test_e_commerce/domain/entities/user_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_view_model.g.dart';

@riverpod
class OnBoardCurrentPage extends _$OnBoardCurrentPage {
  @override
  int build() => 0;

  void assign(index) => state = index;
}

@riverpod
List<OnboardingData> onboardingData(Ref ref) {
  final List<OnboardingData> onboardingData = [
    OnboardingData(
      title: "Choose Products",
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
      icon: Icons.shopping_bag_outlined,
    ),
    OnboardingData(
      title: "Make Payment",
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
      icon: Icons.payment_outlined,
    ),
    OnboardingData(
      title: "Get Your Order",
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
      icon: Icons.shopping_bag,
    ),
  ];
  return onboardingData;
}

@riverpod
List<Image> onboardingImage(Ref ref) {
  final List<Image> onboardingImage = [
    Image.asset(AppImageUtil.splash1),
    Image.asset(AppImageUtil.splash2),
    Image.asset(AppImageUtil.splash3),
  ];

  return onboardingImage;
}

@riverpod
class OnBoardingViewModel extends _$OnBoardingViewModel {
  @override
  Future<void> build() async {}

  Future<FireStoreUser?> getUserFromFirebase() async {
    state = const AsyncLoading();
    try {
      final localRepo = await ref.read(sharedPrefHelperProvider.future);
      final firestore = ref.read(userFirestoreRepoProvider);
      final user = await firestore.getUser(localRepo.userEmail ?? "");
      if (user != null) {
        state = const AsyncData(null);
        return user;
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
    return null;
  }

  Future<void> isOnBoardingDone(FireStoreUser fireStoreUser) async {
    final firestore = ref.read(userFirestoreRepoProvider);
    await firestore.updateUser(fireStoreUser.copyWith(isNewUser: false));
  }
}
