import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aero_nest/main.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID', null);
  });

  testWidgets('AeroNest app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AeroNestApp());
    expect(find.byType(AeroNestApp), findsOneWidget);
  });
}
