import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/portfolio_page.dart';
import '../navigation/home_navigation.dart';
import '../screens/education_form.dart';
import '../screens/project_form.dart';
import '../services/auth_state.dart';
import 'auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.currentPage});

  final PortfolioPage currentPage;

  Future<void> _navigateTo(BuildContext context, PortfolioPage target) async {
    final navigator = Navigator.of(context);
    final isFirstRoute = ModalRoute.of(context)!.isFirst;
    navigator.pop(); // Tutup drawer sebelum berpindah halaman.
    if (target == currentPage) return;

    if (target == PortfolioPage.home) {
      returnToPortfolioHome(navigator, isFirstRoute: isFirstRoute);
      return;
    }

    if (target == PortfolioPage.project) {
      // Pakai konteks navigator karena drawer sudah ditutup.
      final loggedIn = await ensureLoggedIn(navigator.context);
      if (!loggedIn || !navigator.mounted) return;
    }

    final page = target == PortfolioPage.project
        ? const ProjectFormPage(
            drawer: LeftDrawer(currentPage: PortfolioPage.project),
          )
        : const EducationFormPage(
            drawer: LeftDrawer(currentPage: PortfolioPage.education),
          );
    navigator.pushReplacement<void, void>(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
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
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                final auth = context.read<AuthState>();
                Navigator.of(context).pop();
                await auth.logout();
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () async {
                final navigator = Navigator.of(context);
                navigator.pop();
                await ensureLoggedIn(navigator.context);
              },
            ),
        ],
      ),
    );
  }
}
