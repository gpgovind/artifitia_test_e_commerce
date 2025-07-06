import 'package:artifitia_test_e_commerce/data/models/create_payment_request.dart';
import 'package:artifitia_test_e_commerce/data/retrofit/payment_service.dart';
import 'package:artifitia_test_e_commerce/domain/entities/payment_intent.dart';
import 'package:artifitia_test_e_commerce/domain/repositories/payment_domain_repositorie.dart';

class PaymentRepository implements PaymentDomainRepository {
  final PaymentService _api;
  PaymentRepository(this._api);

  @override
  Future<PaymentIntent> createPaymentIntent(
      {required int amount, required String currency}) async {
    final response = await _api.postPayMent(
      body: CreatePaymentIntentRequest(amount: amount, currency: currency),
    );
    return response.toEntity();
  }
}
