import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Akan dilanjutkan 0pada langkah berikutnya
    );
  }
}

class ListChatPage extends StatelessWidget {
  // Tambahkan Data Daftar Chat di dalam class ChatListPage
  final List<Map<String, String>> chats = [
    {
      'name': 'BANGKUMIS FARM',
      'message': 'Segera Memesan Sebelum Kehabisan.',
      'time': '12:30',
      'avatar': 'assets/images/logo.jpg',
    },
    {
      'name': 'BANGKUMIS FARM',
      'message': 'Hallo, Selamat Datang Di BANGKUMIS FARM Official.',
      'time': '12:05',
      'avatar': 'assets/images/logo.jpg',
    },
    // Tambahkan chat lainnya...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tambahkan AppBar dan Tombol Pencarian
      appBar: AppBar(
        title: const Text(
          'List Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF4C53A5),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          // Tambahkan Tombol Filter (Semua & Belum Dibaca)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 19.0,
              vertical: 8.0,
            ),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Semua',
                    style: TextStyle(
                      color: Color(0xFF4C53A5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Belum Dibaca',
                    style: TextStyle(color: Color.fromRGBO(255, 114, 123, 216)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat['avatar']!),
                    radius: 25,
                  ),
                  title: Text(
                    chat['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat['message']!),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat['time']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      if (index == 0)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                    ],
                  ),

                  onTap: () {
                    Navigator.pushNamed(context, "ChatDetail");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
