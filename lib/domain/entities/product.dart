class Product {
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

  const Product({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    required this.details,
    required this.size,
    required this.category,
  });
}
