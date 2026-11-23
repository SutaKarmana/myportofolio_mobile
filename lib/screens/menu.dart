import 'package:material_ui/material_ui.dart';

import '../models/item_homepage.dart';
import '../models/portfolio_page.dart';
import '../widgets/info_card.dart';
import '../widgets/left_drawer.dart';
import '../widgets/project_card.dart';

/// Halaman utama hanya menampilkan profil dan menu, tanpa state lokal.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Setiap item menyimpan nama, ikon, dan warna untuk satu kartu menu.
  static const items = [
    ItemHomepage('Lihat Proyek', Icons.folder_outlined, Color(0xFF355A92)),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle_outline,
      Color(0xFF287763),
      destination: PortfolioPage.project,
    ),
    ItemHomepage(
      'Tambah Edukasi',
      Icons.school_outlined,
      Color(0xFF6A4DA3),
      destination: PortfolioPage.education,
    ),
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
      drawer: const LeftDrawer(currentPage: PortfolioPage.home),
      // Isi halaman dapat digulir saat lebih tinggi daripada layar.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          // Membatasi lebar konten agar tetap nyaman dibaca di layar besar.
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
                // Lebar kartu profil menyesuaikan ruang yang tersedia.
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    // Dua celah masing-masing 12 piksel disisihkan untuk tiga kartu.
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
                // Menu menggunakan dua kolom di ruang sempit dan tiga di ruang lebar.
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
                      // Mengubah setiap data menu menjadi widget ItemCard.
                      children: items.map((item) => ItemCard(item)).toList(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Bagian ini menampilkan pengantar singkat tentang pemilik portofolio.
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: const Color(0xFFEAF0F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.article_outlined, color: Color(0xFF355A92)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tentang Saya',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E60),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Saya menempuh pendidikan S1 Sistem Informasi '
                                'di Universitas Indonesia. Saya tertarik '
                                'mengeksplorasi bagaimana teknologi dan data '
                                'dapat membantu mengembangkan ide bisnis '
                                'serta mendukung pengambilan keputusan.',
                                style: TextStyle(
                                  color: Color(0xFF52617A),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
