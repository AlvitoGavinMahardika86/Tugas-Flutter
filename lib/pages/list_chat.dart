import 'package:flutter/material.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  int _selectedFilter = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'BangKumis Farm Official',
      'message': 'Halo kak! Pesanan pakan super Anda sedang disiapkan ya.',
      'time': '12:30',
      'unread': 1,
      'avatar': 'assets/images/logo.jpg',
      'online': true,
    },
    {
      'name': 'Customer Service BangKumis',
      'message': 'Ada yang bisa kami bantu seputar konsultasi ternak?',
      'time': '10:15',
      'unread': 0,
      'avatar': 'assets/images/logo.jpg',
      'online': true,
    },
    {
      'name': 'BangKumis Tech & Equipment',
      'message': 'Stok timbangan gantung digital 300kg sudah ready kembali.',
      'time': 'Kemarin',
      'unread': 0,
      'avatar': 'assets/images/product.jpg',
      'online': false,
    },
    {
      'name': 'BangKumis Care (Skincare)',
      'message': 'Terima kasih atas review bintang 5 nya kak!',
      'time': '20 Ags',
      'unread': 0,
      'avatar': 'assets/images/logo.jpg',
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == 1
        ? chats.where((c) => (c['unread'] as int) > 0).toList()
        : chats;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'Pesan & Obrolan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E244B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterChip('Semua Obrolan', 0),
                const SizedBox(width: 8),
                _buildFilterChip('Belum Dibaca (1)', 1),
              ],
            ),
          ),
          const Divider(height: 1),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final chat = filtered[index];
                final bool isOnline = chat['online'] as bool;
                final int unread = chat['unread'] as int;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(chat['avatar'] as String),
                          radius: 24,
                        ),
                        if (isOnline)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      chat['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1E244B),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        chat['message'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: unread > 0
                              ? const Color(0xFF1E244B)
                              : Colors.grey.shade600,
                          fontWeight: unread > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat['time'] as String,
                          style: TextStyle(
                            color: unread > 0
                                ? const Color(0xFF2E7D32)
                                : Colors.grey.shade500,
                            fontSize: 11,
                            fontWeight: unread > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (unread > 0) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'DetailChat',
                        arguments: chat['name'],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2E7D32)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

