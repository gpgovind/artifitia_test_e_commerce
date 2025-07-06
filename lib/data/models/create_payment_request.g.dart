// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentIntentRequest _$CreatePaymentIntentRequestFromJson(
        Map<String, dynamic> json) =>
    CreatePaymentIntentRequest(
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$CreatePaymentIntentRequestToJson(
        CreatePaymentIntentRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
    };
