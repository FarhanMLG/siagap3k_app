import 'package:flutter_test/flutter_test.dart';
import 'package:siagap3k_app/main.dart';

void main() {
  testWidgets('SiagaP3K app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SiagaP3KApp());

    // Verify that the bottom navigation items or app bar are rendered.
    expect(find.text('Panduan Darurat P3K'), findsOneWidget);
    expect(find.text('Darurat'), findsOneWidget);
    expect(find.text('Obat P3K'), findsOneWidget);
    expect(find.text('Tentang'), findsOneWidget);
  });
}
