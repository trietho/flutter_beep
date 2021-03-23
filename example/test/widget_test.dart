import 'package:flutter/material.dart';
import 'package:flutter_beep_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify that app with FlutterBeep import renders',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data!.startsWith('Flutter Beep Plugin example app'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Verify that call of FlutterBeep.beep() does not crash',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();

    await tester.tap(find.text("Beep Success"));
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text && widget.data!.startsWith('Beep Success'),
      ),
      findsOneWidget,
    );
  });
}
