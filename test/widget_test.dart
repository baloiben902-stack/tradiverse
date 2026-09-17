import 'package:flutter_test/flutter_test.dart';
import 'package:tradiverse/main.dart';

void main() {
  testWidgets('Tradiverse home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const TradiverseApp());

    expect(find.text('Trade Anything. Value Everything.'), findsOneWidget);
    expect(find.text('My Trades'), findsOneWidget);
    expect(find.text('Reputation'), findsOneWidget);
  });
}
