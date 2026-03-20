import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howcare_app/app.dart';

void main() {
  testWidgets('App renders with bottom tab bar', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.text('어떠케어'), findsOneWidget);
    expect(find.text('홈'), findsWidgets);
    expect(find.text('건강검진'), findsWidgets);
    expect(find.text('건강증진'), findsWidgets);
    expect(find.text('건강체크'), findsWidgets);
    expect(find.text('전체'), findsWidgets);
  });
}
