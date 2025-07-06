import 'package:artifitia_test_e_commerce/domain/entities/product.dart';

class ProductModel {
  final String title;
  final String description;
  final String image;
  final String price;
  final String originalPrice;
  final String discount;
  final String rating;
  final String reviews;
  final List<String> size;
  final String details;
  final String category;

  ProductModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    required this.size,
    required this.details,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '',
      originalPrice: json['originalPrice'] ?? '',
      discount: json['discount'] ?? '',
      rating: json['rating'] ?? '',
      reviews: json['reviews'] ?? '',
      size: List<String>.from(json['size'] ?? []),
      details: json['details'] ?? '',
      category: json['category'] ?? '',
    );
  }

  String get directImageUrl {
    final regex = RegExp(r'd/([^/]+)');
    final match = regex.firstMatch(image);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }
    return image;
  }

  Product toEntity() {
    return Product(
      title: title,
      description: description,
      image: directImageUrl,
      price: price,
      originalPrice: originalPrice,
      discount: discount,
      rating: rating,
      reviews: reviews,
      size: size,
      details: details,
      category: category,
    );
  }
}
