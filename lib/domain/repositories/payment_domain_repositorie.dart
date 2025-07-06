import 'package:artifitia_test_e_commerce/domain/entities/payment_intent.dart';

abstract class PaymentDomainRepository {
  Future<PaymentIntent> createPaymentIntent(
      {required int amount, required String currency});
}
