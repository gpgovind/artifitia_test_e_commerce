
import 'package:artifitia_test_e_commerce/core/config/helper.dart';
import 'package:artifitia_test_e_commerce/data/models/create_payment_request.dart';
import 'package:artifitia_test_e_commerce/data/models/response_status.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'payment_service.g.dart';

@RestApi(baseUrl: "")
abstract class PaymentService {
  factory PaymentService(Dio dio, {String baseUrl}) = _PaymentService;

  @POST(GlobalHelper.paymentIntent)
  Future<PaymentResponse> postPayMent(
      {@Body() required CreatePaymentIntentRequest body});
}
