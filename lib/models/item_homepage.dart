import 'package:material_ui/material_ui.dart';

/// Data yang diperlukan untuk menampilkan satu kartu aksi pada halaman utama.
class ItemHomepage {
  // Ketiga atribut ini menjadi data yang ditampilkan oleh ItemCard.
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}
