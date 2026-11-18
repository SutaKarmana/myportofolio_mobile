import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  // Menjalankan MyApp sebagai widget awal aplikasi.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      // Menentukan tema Material yang digunakan oleh halaman aplikasi.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber[700],
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(), // Halaman yang pertama kali ditampilkan.
    );
  }
}
