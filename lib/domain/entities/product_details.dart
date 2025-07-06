class ProductDetails {
  final String id;
  final String name;
  final String subtitle;
  final List<String> images;
  final int currentPrice;
  final int originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final String selectedSize;
  final String description;
  final String deliveryTime;
  final String category;

  ProductDetails({
    required this.id,
    required this.category,
    required this.name,
    required this.subtitle,
    required this.images,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
    required this.selectedSize,
    required this.description,
    required this.deliveryTime,
  });
}