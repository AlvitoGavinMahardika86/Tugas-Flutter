import 'cart_model.dart';

enum OrderStatus {
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderModel {
  final String orderId;
  final DateTime orderDate;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double shippingFee;
  final double totalAmount;
  final String deliveryAddress;
  final String courierName;
  final String paymentMethod;
  final OrderStatus status;
  final String trackingNumber;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.shippingFee,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.courierName,
    required this.paymentMethod,
    this.status = OrderStatus.processing,
    required this.trackingNumber,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.processing:
        return 'Diproses';
      case OrderStatus.shipped:
        return 'Dikirim';
      case OrderStatus.delivered:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}
