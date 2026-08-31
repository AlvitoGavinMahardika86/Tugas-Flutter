import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2E7D32), width: 2),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/logo.jpg'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Selamat Datang,',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    appState.userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Wishlist icon with badge
            IconButton(
              icon: badges.Badge(
                showBadge: appState.wishlistCount > 0,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFFD32F2F),
                  padding: EdgeInsets.all(5),
                ),
                badgeContent: Text(
                  '${appState.wishlistCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 26,
                  color: Color(0xFFD32F2F),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'WishlistPage');
              },
            ),
            // Notification icon with badge
            IconButton(
              icon: badges.Badge(
                showBadge: appState.unreadNotificationCount > 0,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFFFFA94D),
                  padding: EdgeInsets.all(5),
                ),
                badgeContent: Text(
                  '${appState.unreadNotificationCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  size: 26,
                  color: Color(0xFF2E7D32),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'NotificationsPage');
              },
            ),
            // Chat icon with badge
            IconButton(
              icon: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Color(0xFF66BB6A),
                  padding: EdgeInsets.all(5),
                ),
                badgeContent: const Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 26,
                  color: Color(0xFF2E7D32),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'ListChat');
              },
            ),
          ],
        ),
      ),
    );
  }
}
