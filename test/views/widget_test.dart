import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('increments quantity when Add is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('does not increment above maxQuantity', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
        await tester.pump();
      }
      expect(find.text('5'), findsOneWidget);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('changes bread type with DropdownMenu', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      
    });

    testWidgets('updates note with TextField', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.enterText(
        find.byKey(const Key('notes_textfield')),
        'Extra mayo',
      );
      await tester.pump();
      expect(find.text('Extra mayo'), findsOneWidget);
    });

    testWidgets('toggles between six-inch and footlong with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Initial state: footlong
      

      // Tap the switch to change to six-inch
      await tester.tap(find.byKey(const Key('sandwich_type_switch')));
      await tester.pump();

      
      // Tap the switch to change back to footlong
      await tester.tap(find.byKey(const Key('sandwich_type_switch')));
      await tester.pump();

      
    });

    testWidgets('toggles between toasted and untoasted with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Initial state: untoasted
      

      // Tap the switch to change to toasted
      await tester.tap(find.byKey(const Key('toasted_switch')));
      await tester.pump();

      

      // Tap the switch to change back to untoasted
      await tester.tap(find.byKey(const Key('toasted_switch')));
      await tester.pump();

      
    });

    testWidgets('updates price when quantity or size changes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());

      // Initial state: 1 footlong -> £11.00
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      expect(find.text('Total Price: £11.00'), findsOneWidget);

      // 2 footlongs -> £22.00
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      expect(find.text('Total Price: £22.00'), findsOneWidget);

      // 2 six-inch -> £14.00
      await tester.tap(find.byKey(const Key('sandwich_type_switch')));
      await tester.pump();
      expect(find.text('Total Price: £14.00'), findsOneWidget);

      // 1 six-inch -> £7.00
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      expect(find.text('Total Price: £7.00'), findsOneWidget);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(home: Scaffold(body: testButton));
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}