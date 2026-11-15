import 'package:flutter/material.dart';

/// Kartu yang dapat dipakai ulang untuk setiap informasi identitas.
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E6EF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Menyusun ikon, judul, dan isi identitas secara vertikal.
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF355A92), size: 22),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF65718A),
              ),
            ),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
