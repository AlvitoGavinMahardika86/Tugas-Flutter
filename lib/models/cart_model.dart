import 'product_model.dart';

class CartItem {
  final String id;
  final Product product;
  final String selectedVariant;
  int quantity;
  bool isSelected;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedVariant,
    this.quantity = 1,
    this.isSelected = true,
  });

  double get totalPrice => product.price * quantity;
}

class Coupon {
  final String code;
  final String title;
  final double discountAmount;
  final double minPurchase;
  final double percentage; // e.g. 0.1 for 10%
  final String description;

  const Coupon({
    required this.code,
    required this.title,
    this.discountAmount = 0,
    this.minPurchase = 0,
    this.percentage = 0,
    required this.description,
  });
}
