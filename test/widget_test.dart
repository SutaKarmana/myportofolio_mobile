import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Profil menampilkan informasi yang sesuai', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2506615993'), findsOneWidget);
    expect(find.text('I Nyoman Yadnya Suta Karmana'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);
  });

  for (final menu in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
    testWidgets('Tombol $menu menampilkan SnackBar', (tester) async {
      await tester.pumpWidget(const MyApp());
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

  testWidgets('Drawer mengganti halaman tanpa menumpuk route', (tester) async {
    await tester.pumpWidget(const MyApp());
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

  testWidgets(
    'Form memvalidasi, menampilkan hasil, lalu mengatur ulang input',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.byType(DrawerButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Project'));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      final category = find.byType(DropdownButtonFormField<String>);
      final save = find.text('Save');
      await tester.enterText(fields.at(0), '   ');
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.pumpAndSettle();
      expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);

      await tester.ensureVisible(fields.at(0));
      await tester.enterText(fields.at(0), 'Portofolio');
      await tester.enterText(fields.at(1), 'Aplikasi portofolio pribadi');
      await tester.ensureVisible(category);
      await tester.tap(category);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Data Science').last);
      await tester.pumpAndSettle();
      await tester.ensureVisible(fields.at(2));
      await tester.enterText(fields.at(2), 'Flutter');
      await tester.ensureVisible(fields.at(3));
      await tester.enterText(fields.at(3), 'https://example.com');
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.pumpAndSettle();

      expect(find.text('Nama Proyek: Portofolio'), findsOneWidget);
      expect(
        find.text('Deskripsi: Aplikasi portofolio pribadi'),
        findsOneWidget,
      );
      expect(find.text('Kategori: Data Science'), findsOneWidget);
      expect(find.text('Teknologi: Flutter'), findsOneWidget);
      expect(find.text('Tautan: https://example.com'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      final inputs = tester.widgetList<EditableText>(find.byType(EditableText));
      expect(inputs.map((input) => input.controller.text), everyElement(''));
      expect(
        tester.state<FormFieldState<String>>(category).value,
        'Web Development',
      );
    },
  );
}
