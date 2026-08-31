import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/detail_chat.dart';
import 'pages/product_detail_page.dart';
import 'pages/checkout_page.dart';
import 'pages/order_success_page.dart';
import 'pages/wishlist_page.dart';
import 'pages/order_history_page.dart';
import 'pages/notifications_page.dart';
import 'pages/edit_profile_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BangKumis Farm E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C53A5),
          primary: const Color(0xFF4C53A5),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E244B),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4C53A5),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
        'ProductDetailPage': (context) => const ProductDetailPage(),
        'CartPage': (context) => const CartPage(),
        'CheckoutPage': (context) => const CheckoutPage(),
        'OrderSuccessPage': (context) => const OrderSuccessPage(),
        'WishlistPage': (context) => const WishlistPage(),
        'OrderHistoryPage': (context) => const OrderHistoryPage(),
        'NotificationsPage': (context) => const NotificationsPage(),
        'AccountPage': (context) => const AccountPage(),
        'EditProfilePage': (context) => const EditProfilePage(),
        'ListChat': (context) => const ListChatPage(),
        'DetailChat': (context) => const ChatScreen(),

        // Route aliases for backward compatibility
        'itemsPage': (context) => const ProductDetailPage(),
        'ChatDetail': (context) => const ChatScreen(),
        '/loginPage': (context) => const LoginPage(),
        '/accountPage': (context) => const AccountPage(),
      },
    );
  }
}
