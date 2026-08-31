import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/notification_model.dart';
import '../data/dummy_data.dart';

enum ProductSortOption {
  recommended,
  newest,
  priceLowToHigh,
  priceHighToLow,
  rating,
}

class AppState extends ChangeNotifier {
  // Products
  final List<Product> _products = List.from(DummyData.products);
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  ProductSortOption _productSort = ProductSortOption.recommended;

  // Wishlist
  final Set<String> _wishlistProductIds = {'p1', 'p3'};

  // Cart
  final List<CartItem> _cartItems = [
    CartItem(
      id: 'c_init_1',
      product: DummyData.products[0],
      selectedVariant: 'Karung 25kg',
      quantity: 1,
      isSelected: true,
    ),
    CartItem(
      id: 'c_init_2',
      product: DummyData.products[2],
      selectedVariant: 'Balok 2kg',
      quantity: 2,
      isSelected: true,
    ),
  ];
  Coupon? _appliedCoupon;

  // Orders
  final List<OrderModel> _orders = List.from(DummyData.sampleOrders);

  // Notifications
  final List<AppNotification> _notifications =
      List.from(DummyData.initialNotifications);

  // User profile
  String userName = 'BangKumis Farm';
  String userEmail = 'bangkumisfarm@example.com';
  String userPhone = '0812-3456-7890';
  String userAddress = 'Jl. Raya Peternakan No. 88, Lembang, Bandung Barat';
  double walletBalance = 750000;

  // ================= GETTERS =================
  List<Product> get allProducts => _products;

  List<Product> get filteredProducts {
    final results = _products.where((prod) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          prod.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          prod.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          prod.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    switch (_productSort) {
      case ProductSortOption.recommended:
        results.sort((a, b) {
          final aScore = (a.isPopular ? 2 : 0) + (a.isFlashSale ? 1 : 0);
          final bScore = (b.isPopular ? 2 : 0) + (b.isFlashSale ? 1 : 0);
          final scoreCompare = bScore.compareTo(aScore);
          if (scoreCompare != 0) return scoreCompare;
          return b.rating.compareTo(a.rating);
        });
        break;
      case ProductSortOption.newest:
        results.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case ProductSortOption.priceLowToHigh:
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceHighToLow:
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.rating:
        results.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return results;
  }

  List<Product> get flashSaleProducts =>
      _products.where((p) => p.isFlashSale).toList();

  List<Product> get featuredProducts =>
      _products.where((p) => p.isPopular || p.isFlashSale).toList();

  List<Product> get popularProducts =>
      _products.where((p) => p.isPopular).toList();

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  ProductSortOption get productSort => _productSort;

  List<CartItem> get cartItems => _cartItems;
  Coupon? get appliedCoupon => _appliedCoupon;

  int get cartCount =>
      _cartItems.fold(0, (total, item) => total + item.quantity);

  double get cartSubtotal {
    return _cartItems
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get couponDiscountAmount {
    if (_appliedCoupon == null) return 0;
    final subtotal = cartSubtotal;
    if (subtotal < _appliedCoupon!.minPurchase) return 0;

    if (_appliedCoupon!.percentage > 0) {
      return subtotal * _appliedCoupon!.percentage;
    }
    return _appliedCoupon!.discountAmount;
  }

  double get shippingCost => cartSubtotal > 0 ? 15000 : 0;

  double get cartTotal {
    final subtotal = cartSubtotal;
    if (subtotal == 0) return 0;
    final total = subtotal - couponDiscountAmount + shippingCost;
    return total > 0 ? total : 0;
  }

  bool get isAllSelected =>
      _cartItems.isNotEmpty && _cartItems.every((item) => item.isSelected);

  List<Product> get wishlistProducts =>
      _products.where((p) => _wishlistProductIds.contains(p.id)).toList();

  int get wishlistCount => _wishlistProductIds.length;

  List<OrderModel> get orders => _orders;

  List<AppNotification> get notifications => _notifications;

  int get unreadNotificationCount =>
      _notifications.where((n) => !n.isRead).length;

  // ================= METHODS =================

  // Category & Search
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void setSort(ProductSortOption sortOption) {
    _productSort = sortOption;
    notifyListeners();
  }

  // Wishlist
  bool isFavorite(String productId) => _wishlistProductIds.contains(productId);

  void toggleFavorite(String productId) {
    if (_wishlistProductIds.contains(productId)) {
      _wishlistProductIds.remove(productId);
    } else {
      _wishlistProductIds.add(productId);
    }
    notifyListeners();
  }

  // Cart
  void addToCart(Product product, {String? variant, int quantity = 1}) {
    final chosenVariant = variant ?? (product.variants.isNotEmpty ? product.variants.first : 'Default');
    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedVariant == chosenVariant,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(
        CartItem(
          id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
          product: product,
          selectedVariant: chosenVariant,
          quantity: quantity,
          isSelected: true,
        ),
      );
    }
    notifyListeners();
  }

  void incrementQuantity(String cartItemId) {
    final index = _cartItems.indexWhere((i) => i.id == cartItemId);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String cartItemId) {
    final index = _cartItems.indexWhere((i) => i.id == cartItemId);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((i) => i.id == cartItemId);
    notifyListeners();
  }

  void toggleCartItemSelection(String cartItemId) {
    final index = _cartItems.indexWhere((i) => i.id == cartItemId);
    if (index != -1) {
      _cartItems[index].isSelected = !_cartItems[index].isSelected;
      notifyListeners();
    }
  }

  void toggleSelectAll(bool selectAll) {
    for (var item in _cartItems) {
      item.isSelected = selectAll;
    }
    notifyListeners();
  }

  bool applyCoupon(String couponCode) {
    final found = DummyData.coupons.where(
      (c) => c.code.toUpperCase() == couponCode.trim().toUpperCase(),
    );

    if (found.isNotEmpty) {
      final coupon = found.first;
      if (cartSubtotal >= coupon.minPurchase) {
        _appliedCoupon = coupon;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void removeCoupon() {
    _appliedCoupon = null;
    notifyListeners();
  }

  // Checkout & Order
  OrderModel? placeOrder({
    required String address,
    required String courier,
    required String paymentMethod,
  }) {
    final selectedItems = _cartItems.where((i) => i.isSelected).toList();
    if (selectedItems.isEmpty) return null;

    final sub = cartSubtotal;
    final disc = couponDiscountAmount;
    final ship = shippingCost;
    final total = cartTotal;

    final newOrder = OrderModel(
      orderId: 'BKF-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      orderDate: DateTime.now(),
      items: List.from(selectedItems),
      subtotal: sub,
      discount: disc,
      shippingFee: ship,
      totalAmount: total,
      deliveryAddress: address,
      courierName: courier,
      paymentMethod: paymentMethod,
      status: OrderStatus.processing,
      trackingNumber: 'RES-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
    );

    _orders.insert(0, newOrder);

    // Deduct wallet if paid by wallet
    if (paymentMethod.contains('BangKumis Pay') && walletBalance >= total) {
      walletBalance -= total;
    }

    // Add notification
    _notifications.insert(
      0,
      AppNotification(
        id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
        title: '✅ Pesanan Dikonfirmasi #${newOrder.orderId}',
        message: 'Pesanan Anda sebesar Rp ${total.toInt()} berhasil dibuat dan sedang diproses toko.',
        timestamp: DateTime.now(),
        type: NotificationType.order,
      ),
    );

    // Remove selected items from cart
    _cartItems.removeWhere((i) => i.isSelected);
    _appliedCoupon = null;

    notifyListeners();
    return newOrder;
  }

  // Notifications
  void markNotificationAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  // User Profile & Wallet
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    userName = name;
    userEmail = email;
    userPhone = phone;
    userAddress = address;
    notifyListeners();
  }

  void topUpWallet(double amount) {
    walletBalance += amount;
    _notifications.insert(
      0,
      AppNotification(
        id: 'topup_${DateTime.now().millisecondsSinceEpoch}',
        title: '💳 Top Up Saldo Berhasil',
        message: 'Saldo BangKumis Pay bertambah Rp ${amount.toInt()}. Saldo saat ini: Rp ${walletBalance.toInt()}.',
        timestamp: DateTime.now(),
        type: NotificationType.info,
      ),
    );
    notifyListeners();
  }
}
