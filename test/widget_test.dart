import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

Future<void> pumpPortfolioWithAuth(
  WidgetTester tester, {
  String? initialToken,
  int createProjectStatus = 201,
  List<http.Request>? projectRequests,
}) async {
  final httpClient = MockClient((request) async {
    if (request.url.path == '/api/v1/auth/token/') {
      return http.Response('{"token":"test-token"}', 200);
    }
    if (request.url.path == '/api/v1/auth/logout/') {
      return http.Response('', 204);
    }
    if (request.url.path == '/api/v1/projects/' && request.method == 'POST') {
      projectRequests?.add(request);
      return http.Response(request.body, createProjectStatus);
    }
    throw StateError('Request tidak diharapkan: ${request.url.path}');
  });
  addTearDown(httpClient.close);
  final apiClient = ApiClient(client: httpClient);
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(
          create: (_) => AuthState(apiClient, initialToken: initialToken),
        ),
      ],
      child: const MaterialApp(home: MyHomePage()),
    ),
  );
}

void main() {
  testWidgets('Profil menampilkan informasi yang sesuai', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506615993'), findsOneWidget);
    expect(find.text('I Nyoman Yadnya Suta Karmana'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);
  });

  for (final menu in ['Lihat Proyek', 'Tambah Proyek']) {
    testWidgets('Tombol $menu menampilkan SnackBar', (tester) async {
      if (menu == 'Tambah Proyek') {
        await pumpPortfolioWithAuth(tester, initialToken: 'test-token');
      } else {
        await tester.pumpWidget(const MyApp());
      }
      await tester.ensureVisible(find.text(menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text(menu));
      await tester.pumpAndSettle();
      expect(find.text('Kamu telah menekan tombol $menu!'), findsOneWidget);

      if (menu == 'Tambah Proyek') {
        expect(find.text('Add Project Form'), findsOneWidget);
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.text('Menu Portofolio'), findsOneWidget);
      }
    });
  }

  testWidgets('Kartu meminta login untuk tambah proyek dan bisa logout', (
    tester,
  ) async {
    await pumpPortfolioWithAuth(tester);
    final card = find.text('Tambah Proyek');
    await tester.ensureVisible(card);
    await tester.tap(card);
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'pengguna-uji');
    await tester.enterText(fields.at(1), 'kata-sandi-uji');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project Form'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    final logout = find.text('Logout');
    await tester.ensureVisible(logout);
    await tester.tap(logout);
    await tester.pumpAndSettle();
    expect(find.text('Berhasil logout.'), findsOneWidget);

    final home = tester.element(find.text('Menu Portofolio'));
    expect(home.read<AuthState>().isLoggedIn, isFalse);
  });

  testWidgets('Drawer mengganti halaman tanpa menumpuk route', (tester) async {
    await pumpPortfolioWithAuth(tester, initialToken: 'test-token');
    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    final formTitle = find.text('Add Project Form');
    expect(formTitle, findsOneWidget);
    expect(Navigator.of(tester.element(formTitle)).canPop(), isFalse);

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Menu Portofolio'), findsOneWidget);
  });

  testWidgets('Drawer meminta login sebelum membuka Add Project', (
    tester,
  ) async {
    await pumpPortfolioWithAuth(tester);
    final addProject = find.text('Add Project');
    final projectForm = find.text('Add Project Form');
    final drawer = find.byType(DrawerButton);
    final loginTile = find.widgetWithText(ListTile, 'Login');
    final logoutTile = find.widgetWithText(ListTile, 'Logout');

    await tester.tap(drawer);
    await tester.pumpAndSettle();
    expect(loginTile, findsOneWidget);
    await tester.tap(addProject);
    await tester.pumpAndSettle();
    expect(find.text('Username'), findsOneWidget);
    expect(projectForm, findsNothing);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Menu Portofolio'), findsOneWidget);

    await tester.tap(drawer);
    await tester.pumpAndSettle();
    await tester.tap(addProject);
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'pengguna-uji');
    await tester.enterText(fields.at(1), 'kata-sandi-uji');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(projectForm, findsOneWidget);

    await tester.tap(drawer);
    await tester.pumpAndSettle();
    expect(logoutTile, findsOneWidget);
    await tester.tap(logoutTile);
    await tester.pumpAndSettle();
    await tester.tap(drawer);
    await tester.pumpAndSettle();
    expect(loginTile, findsOneWidget);
    expect(logoutTile, findsNothing);
  });

  testWidgets('Kartu Edukasi membuka formulir dan Back kembali ke beranda', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final card = find.text('Tambah Edukasi');
    await tester.ensureVisible(card);
    await tester.tap(card);
    await tester.pumpAndSettle();

    expect(find.text('Institusi'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Menu Portofolio'), findsOneWidget);
  });

  const formEntries = [
    (card: 'Tambah Edukasi', drawer: 'Add Education'),
    (card: 'Tambah Proyek', drawer: 'Add Project'),
  ];
  for (final form in formEntries) {
    for (final fromDrawer in [false, true]) {
      final entryPoint = fromDrawer ? 'drawer' : 'kartu';
      testWidgets('Back pada ${form.card} dari $entryPoint membuka beranda', (
        tester,
      ) async {
        await pumpPortfolioWithAuth(tester, initialToken: 'test-token');

        if (fromDrawer) {
          await tester.tap(find.byType(DrawerButton));
          await tester.pumpAndSettle();
          await tester.tap(find.text(form.drawer));
        } else {
          final card = find.text(form.card);
          await tester.ensureVisible(card);
          await tester.tap(card);
        }
        await tester.pumpAndSettle();

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        final menu = find.text('Menu Portofolio');
        expect(menu, findsOneWidget);
        expect(Navigator.of(tester.element(menu)).canPop(), isFalse);
      });
    }
  }

  testWidgets('Drawer membuka Edukasi, Proyek, dan kembali ke Home', (
    tester,
  ) async {
    await pumpPortfolioWithAuth(tester, initialToken: 'test-token');

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();
    final institution = find.text('Institusi');
    expect(institution, findsOneWidget);
    expect(Navigator.of(tester.element(institution)).canPop(), isFalse);

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<ListTile>(find.widgetWithText(ListTile, 'Add Education'))
          .selected,
      isTrue,
    );
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project Form'), findsOneWidget);

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();
    expect(institution, findsOneWidget);

    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Menu Portofolio'), findsOneWidget);
  });

  testWidgets('Form memvalidasi URL dan mengirim POST proyek dengan token', (
    tester,
  ) async {
    final requests = <http.Request>[];
    await pumpPortfolioWithAuth(
      tester,
      initialToken: 'test-token',
      projectRequests: requests,
    );
    await tester.tap(find.byType(DrawerButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    final save = find.text('Save');
    await tester.enterText(fields.at(0), '   ');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(requests, isEmpty);

    await tester.ensureVisible(fields.at(0));
    await tester.enterText(fields.at(0), 'Portofolio');
    await tester.enterText(fields.at(1), 'Aplikasi portofolio pribadi');
    await tester.ensureVisible(fields.at(2));
    await tester.enterText(fields.at(2), 'Flutter');
    await tester.ensureVisible(fields.at(3));
    await tester.enterText(fields.at(3), 'bukan-url');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(
      find.text('Masukkan URL yang diawali http:// atau https://.'),
      findsOneWidget,
    );
    expect(requests, isEmpty);

    await tester.ensureVisible(fields.at(3));
    await tester.enterText(fields.at(3), 'https://example.com');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    final request = requests.single;
    expect(request.headers['authorization'], 'Token test-token');
    expect(jsonDecode(request.body), {
      'title': 'Portofolio',
      'description': 'Aplikasi portofolio pribadi',
      'tech_stack': 'Flutter',
      'project_url': 'https://example.com',
      'project_image_url': '',
    });
    expect(find.text('Nama Proyek: Portofolio'), findsOneWidget);
    expect(find.text('Deskripsi: Aplikasi portofolio pribadi'), findsOneWidget);
    expect(find.text('Teknologi: Flutter'), findsOneWidget);
    expect(find.text('Tautan: https://example.com'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    final inputs = tester.widgetList<EditableText>(find.byType(EditableText));
    expect(inputs.map((input) => input.controller.text), everyElement(''));
  });

  testWidgets('Respons 401 membuka login ulang dan mempertahankan isian', (
    tester,
  ) async {
    await pumpPortfolioWithAuth(
      tester,
      initialToken: 'test-token',
      createProjectStatus: 401,
    );
    final card = find.text('Tambah Proyek');
    await tester.ensureVisible(card);
    await tester.tap(card);
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Proyek uji');
    await tester.enterText(fields.at(1), 'Deskripsi');
    await tester.ensureVisible(fields.at(2));
    await tester.enterText(fields.at(2), 'Flutter');
    // Biarkan SnackBar kartu selesai sebelum menekan tombol di bawah form.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    final save = find.text('Save');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(find.text('Username'), findsOneWidget);
    final login = tester.element(find.text('Username'));
    expect(login.read<AuthState>().isLoggedIn, isFalse);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Proyek uji'), findsOneWidget);
  });
}
