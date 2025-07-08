class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> sizes;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      name: map['name'] ?? 'No Name',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] as num? ?? 0).toDouble(),
      rating: (map['rating'] as num? ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] as int? ?? 0,
      sizes: List<String>.from(map['sizes'] ?? []),
    );
  }
}