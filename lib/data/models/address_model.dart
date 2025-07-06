import 'package:artifitia_test_e_commerce/domain/entities/address.dart';

class AddressModel {
  final String email;
  final String password;
  final String pincode;
  final String address;
  final String city;
  final String state;
  final String country;
  final String bankAccount;
  final String accountHolderName;
  final String ifscCode;

  AddressModel({
    required this.email,
    required this.password,
    required this.pincode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.bankAccount,
    required this.accountHolderName,
    required this.ifscCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      pincode: json['pincode'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      bankAccount: json['bankAccount'] ?? '',
      accountHolderName: json['accountHolderName'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'pincode': pincode,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'bankAccount': bankAccount,
      'accountHolderName': accountHolderName,
      'ifscCode': ifscCode,
    };
  }

  Address toEntity() {
    return Address(
      email: email,
      password: password,
      pincode: pincode,
      address: address,
      city: city,
      state: state,
      country: country,
      bankAccount: bankAccount,
      accountHolderName: accountHolderName,
      ifscCode: ifscCode,
    );
  }
}
