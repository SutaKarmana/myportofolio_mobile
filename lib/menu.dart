import 'package:flutter/material.dart';

import 'models/item_homepage.dart';
import 'widgets/info_card.dart';
import 'widgets/item_card.dart';

/// Halaman utama hanya menampilkan profil dan menu, tanpa state lokal.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const items = [
    ItemHomepage('Lihat Proyek', Icons.folder_outlined, Color(0xFF355A92)),
    ItemHomepage('Tambah Proyek', Icons.add_circle_outline, Color(0xFF287763)),
    ItemHomepage('Logout', Icons.logout, Color(0xFFAD4D4D)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: const Border(
                      left: BorderSide(color: Color(0xFF355A92), width: 5),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, selamat datang!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E60),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Portofolio pribadi Suta',
                        style: TextStyle(color: Color(0xFF65718A)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Wrap memberi kartu ruang untuk turun ke baris berikutnya.
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final cardWidth = width < 500 ? width : (width - 24) / 3;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            title: 'NPM',
                            content: '2506615993',
                            icon: Icons.badge_outlined,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            title: 'Name',
                            content: 'I Nyoman Yadnya Suta Karmana',
                            icon: Icons.person_outline,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            title: 'Class',
                            content: 'PBP F',
                            icon: Icons.school_outlined,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Menu Portofolio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E60),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pilih kartu untuk melihat pesan menu.',
                  style: TextStyle(color: Color(0xFF65718A)),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      crossAxisCount: constraints.maxWidth < 500 ? 2 : 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      // Tinggi tetap menjaga kartu tidak terlalu besar di web.
                      mainAxisExtent: 160,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: items.map((item) => ItemCard(item)).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
