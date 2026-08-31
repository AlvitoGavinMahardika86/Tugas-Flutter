import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'account_page.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';
import '../widgets/CategoriesWidget.dart';
import '../widgets/ItemsWidget.dart';
import '../widgets/HomeAppBar.dart';
import '../widgets/promo_carousel.dart';
import '../providers/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePageContent(),
          CartPage(),
          WishlistPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF2E7D32),
        height: 65.0,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          const Icon(Icons.home_filled, size: 28.0, color: Colors.white),
          badges.Badge(
            showBadge: appState.cartCount > 0,
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.redAccent,
              padding: EdgeInsets.all(5),
            ),
            badgeContent: Text(
              '${appState.cartCount}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 28.0,
              color: Colors.white,
            ),
          ),
          badges.Badge(
            showBadge: appState.wishlistCount > 0,
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.redAccent,
              padding: EdgeInsets.all(5),
            ),
            badgeContent: Text(
              '${appState.wishlistCount}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: const Icon(
              Icons.favorite_outline,
              size: 28.0,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.person_outline_rounded,
            size: 28.0,
            color: Colors.white,
          ),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildQuickStat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E244B),
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final featuredProducts = appState.featuredProducts.take(5).toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const HomeAppBar(),

        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Flash Deal Hari Ini',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Diskon sampai 50%\nuntuk kebutuhan ternak Anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _Pill(label: 'Gratis Ongkir'),
                        _Pill(label: 'Cashback 5%'),
                        _Pill(label: 'Produk Baru'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 98,
                height: 98,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '12:30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Berakhir',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final hasRoomForThree = constraints.maxWidth > 520;

              if (!hasRoomForThree) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: (constraints.maxWidth - 10) / 2,
                      child: _buildQuickStat(
                        'Produk',
                        '${appState.allProducts.length}',
                        Icons.inventory_2,
                        const Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(
                      width: (constraints.maxWidth - 10) / 2,
                      child: _buildQuickStat(
                        'Favorit',
                        '${appState.wishlistCount}',
                        Icons.favorite,
                        Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: _buildQuickStat(
                        'Pesanan',
                        '${appState.orders.length}',
                        Icons.local_shipping,
                        Colors.green,
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  _buildQuickStat(
                    'Produk',
                    '${appState.allProducts.length}',
                    Icons.inventory_2,
                    const Color(0xFF2E7D32),
                  ),
                  const SizedBox(width: 10),
                  _buildQuickStat(
                    'Favorit',
                    '${appState.wishlistCount}',
                    Icons.favorite,
                    Colors.redAccent,
                  ),
                  const SizedBox(width: 10),
                  _buildQuickStat(
                    'Pesanan',
                    '${appState.orders.length}',
                    Icons.local_shipping,
                    Colors.green,
                  ),
                ],
              );
            },
          ),
        ),

        Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 22, color: Color(0xFF2E7D32)),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: appState.setSearchQuery,
                  decoration: const InputDecoration(
                    hintText: 'Cari produk favorit Anda...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    appState.clearSearch();
                  },
                  child: const Icon(Icons.close_rounded, color: Colors.grey),
                ),
            ],
          ),
        ),

        const PromoCarousel(),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rekomendasi Hari Ini',
                style: TextStyle(
                  color: Color(0xFF1E244B),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Lihat semua',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featuredProducts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  'ProductDetailPage',
                  arguments: product,
                ),
                child: Container(
                  width: 170,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          product.image,
                          height: 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E244B),
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (m) => "${m[1]}.")}',
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kategori Pilihan',
                style: TextStyle(
                  color: Color(0xFF1E244B),
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (appState.selectedCategory != 'Semua')
                GestureDetector(
                  onTap: () => appState.selectCategory('Semua'),
                  child: const Text(
                    'Reset Filter',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              PopupMenuButton<ProductSortOption>(
                icon: const Icon(Icons.sort_rounded, color: Color(0xFF2E7D32)),
                tooltip: 'Urutkan produk',
                onSelected: appState.setSort,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: ProductSortOption.recommended,
                    child: Text('Rekomendasi'),
                  ),
                  PopupMenuItem(
                    value: ProductSortOption.priceLowToHigh,
                    child: Text('Harga: Rendah ke Tinggi'),
                  ),
                  PopupMenuItem(
                    value: ProductSortOption.priceHighToLow,
                    child: Text('Harga: Tinggi ke Rendah'),
                  ),
                  PopupMenuItem(
                    value: ProductSortOption.rating,
                    child: Text('Rating Tertinggi'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const CategoriesWidget(),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Produk Unggulan',
                    style: TextStyle(
                      color: Color(0xFF1E244B),
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${appState.filteredProducts.length} Produk',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.tune_rounded, size: 20, color: Color(0xFF2E7D32)),
            ],
          ),
        ),

        const SizedBox(height: 6),

        const ItemsWidget(),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;

  const _Pill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
