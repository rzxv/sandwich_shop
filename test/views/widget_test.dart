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
    testWidgets('shows initial quantity of 1', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('increments quantity when Add is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
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


    testWidgets('toggles between six-inch and footlong with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(Switch));
      await tester.pump();
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

  group('New Features', () {
    testWidgets('AppBar displays logo and title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that the AppBar contains the logo and title.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.widgetWithImage(AppBar, const AssetImage('assets/images/logo.png')), findsOneWidget);
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('Add to Cart button shows a SnackBar', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that the initial quantity is 1.
      expect(find.text('1'), findsOneWidget);

      // Find the "Add to Cart" button.
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      expect(addToCartButton, findsOneWidget);

      // Tap the "Add to Cart" button.
      await tester.tap(addToCartButton);
      await tester.pump(); // Allow time for the SnackBar to appear.
      await tester.pump(const Duration(milliseconds: 500)); // and settle.

      // Verify that the SnackBar is displayed with the correct message.
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Added 1 footlong Veggie Delight sandwich(es)'), findsOneWidget);
    });

    testWidgets('Add to Cart button is disabled when quantity is 0', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Decrease the quantity to 0.
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Verify that the quantity is 0.
      expect(find.text('0'), findsOneWidget);

      // Verify that the "Add to Cart" button is disabled.
      final StyledButton styledButton = tester.widget(find.widgetWithText(StyledButton, 'Add to Cart'));
      expect(styledButton.onPressed, isNull);
    });
  });
}
