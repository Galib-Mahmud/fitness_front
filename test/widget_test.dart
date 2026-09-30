import 'package:flutter_test/flutter_test.dart';
import 'package:rentor/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrainerMatchApp());
    expect(find.text('TrainerMatch'), findsOneWidget);
  });
}
