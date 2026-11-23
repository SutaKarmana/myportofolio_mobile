import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

void main() {
  const app = MaterialApp(home: EducationFormPage());

  testWidgets('Form edukasi menolak isian wajib dan urutan tahun yang salah', (
    tester,
  ) async {
    await tester.pumpWidget(app);
    final fields = find.byType(TextFormField);
    final save = find.text('Simpan');

    await tester.enterText(fields.at(0), '   ');
    await tester.enterText(fields.at(2), '20');
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(find.text('Institusi wajib diisi.'), findsOneWidget);
    expect(find.text('Program studi wajib diisi.'), findsOneWidget);
    expect(find.text('Masukkan tahun dalam empat digit.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.enterText(fields.at(0), 'Universitas Indonesia');
    await tester.enterText(fields.at(1), 'Sistem Informasi');
    await tester.enterText(fields.at(2), '2025');
    await tester.enterText(fields.at(3), '2024');
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(
      find.text('Tahun selesai tidak boleh sebelum tahun mulai.'),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Form edukasi bisa disimpan dari layar sempit dengan keyboard', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(app);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Universitas Indonesia');
    await tester.enterText(fields.at(1), 'Sistem Informasi');
    await tester.enterText(fields.at(2), '2025');

    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    final save = find.text('Simpan');
    await tester.ensureVisible(save);
    await tester.tap(save);
    tester.view.resetViewInsets();
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Edukasi'), findsOneWidget);
    expect(
      find.text(
        'Institusi: Universitas Indonesia\n'
        'Program Studi: Sistem Informasi\n'
        'Tahun Mulai: 2025\n'
        'Tahun Selesai: Belum diisi',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('2025'), findsOneWidget);
  });
}
