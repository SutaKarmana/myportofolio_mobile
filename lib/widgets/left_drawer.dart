import 'package:material_ui/material_ui.dart';

import '../screens/menu.dart';
import '../screens/project_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.isHome});

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Portfolio',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore personal projects and experiences!',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selected: isHome,
            onTap: () {
              final navigator = Navigator.of(context);
              final isFirstRoute = ModalRoute.of(context)!.isFirst;
              navigator.pop(); // Tutup drawer sebelum berpindah halaman.
              if (isHome) return;

              if (isFirstRoute) {
                navigator.pushReplacement<void, void>(
                  MaterialPageRoute<void>(builder: (_) => const MyHomePage()),
                );
              } else {
                // Jika form dibuka dari kartu, beranda sudah ada di bawahnya.
                navigator.pop();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            selected: !isHome,
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (!isHome) return;

              navigator.pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (_) =>
                      const ProjectFormPage(drawer: LeftDrawer(isHome: false)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
