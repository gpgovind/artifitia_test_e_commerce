import 'package:artifitia_test_e_commerce/domain/entities/payment_intent.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_status.g.dart';

@JsonSerializable()
class PaymentResponse {
  @JsonKey(name: "clientSecret")
  final String clientSecret;

  PaymentResponse({required this.clientSecret});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);

  PaymentIntent toEntity() {
    return PaymentIntent(clientSecret: clientSecret);
  }
}
