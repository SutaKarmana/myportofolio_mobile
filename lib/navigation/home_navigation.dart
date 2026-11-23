import 'package:material_ui/material_ui.dart';

import '../screens/menu.dart';

void returnToPortfolioHome(
  NavigatorState navigator, {
  required bool isFirstRoute,
}) {
  // Kartu menyisakan beranda di bawah form, sedangkan drawer bisa menggantinya.
  if (!isFirstRoute) {
    navigator.pop();
    return;
  }

  navigator.pushReplacement<void, void>(
    MaterialPageRoute<void>(builder: (_) => const MyHomePage()),
  );
}
