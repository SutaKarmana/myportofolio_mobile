import 'package:flutter_test/flutter_test.dart';
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
    });
  }
}
