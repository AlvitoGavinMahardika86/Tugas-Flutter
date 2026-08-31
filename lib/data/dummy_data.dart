import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/notification_model.dart';
import '../models/order_model.dart';

class DummyData {
  static final List<String> categories = [
    'Semua',
    'Outfit',
    'Pakan Ternak',
    'Skincare',
    'Elektronik',
    'Farm Tools',
  ];

  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Ampas Tahu Nutrisi Super Sapi & Kambing',
      category: 'Pakan Ternak',
      price: 95000,
      originalPrice: 150000,
      discountPercent: 37,
      rating: 4.9,
      reviewCount: 428,
      description:
          'Ampas tahu fermentasi kualitas premium pilihan peternak. Kaya akan protein nabati dan serat kasar yang mudah dicerna, terbukti mempercepat penggemukan sapi, domba, dan kambing secara sehat dan alami.',
      image: 'assets/images/product.jpg',
      variants: ['Karung 25kg', 'Karung 50kg', 'Paket Hemat 100kg'],
      stock: 45,
      isPopular: true,
      isFlashSale: true,
      seller: 'BangKumis Farm Official',
    ),
    Product(
      id: 'p2',
      name: 'Kaos Peternak Milenial BangKumis Cotton 24s',
      category: 'Outfit',
      price: 85000,
      originalPrice: 120000,
      discountPercent: 29,
      rating: 4.8,
      reviewCount: 184,
      description:
          'Kaos distro bertema peternakan modern dengan bahan 100% combed cotton 24s yang adem, menyerap keringat, dan sangat nyaman dipakai saat beraktivitas di kandang maupun santai.',
      image: 'assets/images/logo.jpg',
      variants: ['Size M', 'Size L', 'Size XL', 'Size XXL'],
      stock: 30,
      isPopular: true,
      isFlashSale: false,
      seller: 'BangKumis Farm Official',
    ),
    Product(
      id: 'p3',
      name: 'Mineral Block Salt Lick Plus Multivitamin',
      category: 'Pakan Ternak',
      price: 45000,
      originalPrice: 65000,
      discountPercent: 30,
      rating: 4.9,
      reviewCount: 312,
      description:
          'Batu jilat garam mineral lengkap dengan kalsium, fosfor, dan selenium untuk mencegah kelumpuhan dan meningkatkan nafsu makan ternak.',
      image: 'assets/images/product.jpg',
      variants: ['Balok 2kg', 'Balok 5kg', 'Bundle 4 Balok'],
      stock: 60,
      isPopular: true,
      isFlashSale: true,
      seller: 'BangKumis Farm Official',
    ),
    Product(
      id: 'p4',
      name: 'Serum Herbal Glowing Anti-Kusam Alami',
      category: 'Skincare',
      price: 110000,
      originalPrice: 175000,
      discountPercent: 37,
      rating: 4.7,
      reviewCount: 95,
      description:
          'Serum wajah dengan ekstrak bahan alami formula khusus untuk mencerahkan, melembapkan, dan melindungi kulit dari polusi luar ruangan.',
      image: 'assets/images/logo.jpg',
      variants: ['Botol 20ml', 'Botol 30ml', 'Twin Pack'],
      stock: 25,
      isPopular: false,
      isFlashSale: false,
      seller: 'BangKumis Care',
    ),
    Product(
      id: 'p5',
      name: 'Timbangan Digital Gantung Ternak 300kg Pro',
      category: 'Elektronik',
      price: 245000,
      originalPrice: 350000,
      discountPercent: 30,
      rating: 4.9,
      reviewCount: 156,
      description:
          'Timbangan gantung digital presisi tinggi dengan kapasitas hingga 300kg. Dilengkapi layar LCD backlit terang, hook baja anti karat, dan baterai tahan lama.',
      image: 'assets/images/product.jpg',
      variants: ['Kapasitas 150kg', 'Kapasitas 300kg', 'Kapasitas 500kg'],
      stock: 18,
      isPopular: true,
      isFlashSale: true,
      seller: 'BangKumis Tech',
    ),
    Product(
      id: 'p6',
      name: 'Sprayer Elektrik Tanaman & Kandang 16 Liter',
      category: 'Farm Tools',
      price: 320000,
      originalPrice: 450000,
      discountPercent: 28,
      rating: 4.8,
      reviewCount: 220,
      description:
          'Alat semprot elektrik serbaguna untuk disinfektan kandang ternak dan penyemprotan tanaman pertanian. Tekanan kuat dan baterai tahan hingga 6 jam pemakaian.',
      image: 'assets/images/product.jpg',
      variants: ['16 Liter Standar', '16 Liter + Nozzle Set 4in1'],
      stock: 14,
      isPopular: false,
      isFlashSale: false,
      seller: 'BangKumis Farm Official',
    ),
  ];

  static final List<Coupon> coupons = [
    Coupon(
      code: 'DISKON50',
      title: 'Diskon Spesial 50 Ribu',
      discountAmount: 50000,
      minPurchase: 150000,
      description: 'Potongan langsung Rp 50.000 dengan min. belanja Rp 150.000',
    ),
    Coupon(
      code: 'FARMHEMAT',
      title: 'Voucher Pelanggan Setia 20%',
      percentage: 0.20,
      minPurchase: 100000,
      description: 'Diskon 20% tanpa batas maksimal untuk semua produk pakan',
    ),
    Coupon(
      code: 'GRATISONGKIR',
      title: 'Potongan Ongkos Kirim',
      discountAmount: 20000,
      minPurchase: 50000,
      description: 'Potongan ongkir hingga Rp 20.000 ke seluruh Indonesia',
    ),
  ];

  static final List<AppNotification> initialNotifications = [
    AppNotification(
      id: 'n1',
      title: '🔥 Flash Sale BangKumis Dimulai!',
      message: 'Dapatkan diskon hingga 50% untuk pakan dan ampas tahu pilihan hari ini!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      type: NotificationType.promo,
      isRead: false,
    ),
    AppNotification(
      id: 'n2',
      title: '📦 Pesanan #BKF-9821 Telah Dikirim',
      message: 'Kurir JNE Express sedang mengantar pesanan Anda menuju alamat tujuan.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.order,
      isRead: false,
    ),
    AppNotification(
      id: 'n3',
      title: '🎉 Selamat Datang di BangKumis Farm',
      message: 'Gunakan kode voucher DISKON50 untuk mendapatkan potongan belanja pertama Anda!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.info,
      isRead: true,
    ),
  ];

  static final List<OrderModel> sampleOrders = [
    OrderModel(
      orderId: 'BKF-89210',
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      items: [
        CartItem(
          id: 'ci1',
          product: products[0],
          selectedVariant: 'Karung 25kg',
          quantity: 2,
        ),
      ],
      subtotal: 190000,
      discount: 20000,
      shippingFee: 15000,
      totalAmount: 185000,
      deliveryAddress: 'Jl. Merdeka No. 45, Bandung, Jawa Barat (081234567890)',
      courierName: 'JNE Reguler (2-3 Hari)',
      paymentMethod: 'GoPay / QRIS',
      status: OrderStatus.shipped,
      trackingNumber: 'JNE-99201948210',
    ),
    OrderModel(
      orderId: 'BKF-87123',
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      items: [
        CartItem(
          id: 'ci2',
          product: products[2],
          selectedVariant: 'Balok 2kg',
          quantity: 1,
        ),
        CartItem(
          id: 'ci3',
          product: products[1],
          selectedVariant: 'Size L',
          quantity: 1,
        ),
      ],
      subtotal: 130000,
      discount: 0,
      shippingFee: 10000,
      totalAmount: 140000,
      deliveryAddress: 'Jl. Merdeka No. 45, Bandung, Jawa Barat (081234567890)',
      courierName: 'SiCepat BEST',
      paymentMethod: 'Bank Transfer (BCA)',
      status: OrderStatus.delivered,
      trackingNumber: 'SCP-8192039128',
    ),
  ];
}
