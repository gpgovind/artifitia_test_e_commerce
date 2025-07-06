import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'payment_view_model.g.dart';

final isFavoriteProvider = StateProvider<bool>((ref) => false);
final isQuantityProvider = StateProvider<int>((ref) => 1);
final isPriceProvider = StateProvider<int>((ref) => 1);

@riverpod
class PaymentViewModel extends _$PaymentViewModel {
  @override
  FutureOr<void> build() {}

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    state = const AsyncLoading();

    try {
      final repo = await ref.read(paymentRepositoryProvider.future);
      final result =
          await repo.createPaymentIntent(amount: amount, currency: currency);
      state = const AsyncData(null);
      return result.clientSecret;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<void> makePayment(int amount, String currency) async {
    try {
      state = const AsyncLoading();

      final clientSecret = await _createPaymentIntent(amount, currency);
      if (clientSecret == null) {
        log("Failed to get client secret");
        state = AsyncError("Failed to get client secret", StackTrace.current);
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Artifitia E-Commerce',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      state = const AsyncData(null);
      log('✅ Payment successful!');
    } catch (e, st) {
      log('❌ Payment failed: $e');
      if (e is StripeException) {
        log('Stripe Error: ${e.error.localizedMessage}');
      }
      state = AsyncError(e, st); // only once!
    }
  }
}
