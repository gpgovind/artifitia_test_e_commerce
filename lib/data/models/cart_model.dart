import 'package:artifitia_test_e_commerce/domain/entities/cart_list.dart';

class CartModel {
  final String productId;

  CartModel({required this.productId});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
    };
  }

  CartList toEntity() {
    return CartList(productId: productId);
  }
}
