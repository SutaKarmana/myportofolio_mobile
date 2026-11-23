import 'package:material_ui/material_ui.dart';

import '../models/portfolio_page.dart';
import '../screens/education_form.dart';
import '../screens/menu.dart';
import '../screens/project_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.currentPage});

  final PortfolioPage currentPage;

  void _navigateTo(BuildContext context, PortfolioPage target) {
    final navigator = Navigator.of(context);
    final isFirstRoute = ModalRoute.of(context)!.isFirst;
    navigator.pop(); // Tutup drawer sebelum berpindah halaman.
    if (target == currentPage) return;

    if (target == PortfolioPage.home && !isFirstRoute) {
      // Form yang dibuka dari kartu masih memiliki beranda di bawahnya.
      navigator.pop();
      return;
    }

    final page = switch (target) {
      PortfolioPage.home => const MyHomePage(),
      PortfolioPage.project => const ProjectFormPage(
        drawer: LeftDrawer(currentPage: PortfolioPage.project),
      ),
      PortfolioPage.education => const EducationFormPage(
        drawer: LeftDrawer(currentPage: PortfolioPage.education),
      ),
    };
    navigator.pushReplacement<void, void>(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

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
            selected: currentPage == PortfolioPage.home,
            onTap: () => _navigateTo(context, PortfolioPage.home),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            selected: currentPage == PortfolioPage.project,
            onTap: () => _navigateTo(context, PortfolioPage.project),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            selected: currentPage == PortfolioPage.education,
            onTap: () => _navigateTo(context, PortfolioPage.education),
          ),
        ],
      ),
    );
  }
}
