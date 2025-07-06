import 'package:json_annotation/json_annotation.dart';
part 'create_payment_request.g.dart';

@JsonSerializable()
class CreatePaymentIntentRequest {
    @JsonKey(name: "amount")
    final int amount;
    @JsonKey(name: "currency")
    final String currency;

    CreatePaymentIntentRequest({
        required this.amount,
        required this.currency,
    });

    factory CreatePaymentIntentRequest.fromJson(Map<String, dynamic> json) => _$CreatePaymentIntentRequestFromJson(json);

    Map<String, dynamic> toJson() => _$CreatePaymentIntentRequestToJson(this);
}
