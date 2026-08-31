class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double originalPrice;
  final int discountPercent;
  final double rating;
  final int reviewCount;
  final String description;
  final String image;
  final List<String> variants;
  final int stock;
  final bool isPopular;
  final bool isFlashSale;
  final String seller;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.image,
    required this.variants,
    required this.stock,
    this.isPopular = false,
    this.isFlashSale = false,
    this.seller = 'BangKumis Farm Official',
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    double? originalPrice,
    int? discountPercent,
    double? rating,
    int? reviewCount,
    String? description,
    String? image,
    List<String>? variants,
    int? stock,
    bool? isPopular,
    bool? isFlashSale,
    String? seller,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      image: image ?? this.image,
      variants: variants ?? this.variants,
      stock: stock ?? this.stock,
      isPopular: isPopular ?? this.isPopular,
      isFlashSale: isFlashSale ?? this.isFlashSale,
      seller: seller ?? this.seller,
    );
  }
}
