import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich', () {
    test('constructor assigns properties correctly', () {
      // Arrange
      const sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      // Assert
      expect(sandwich.type, SandwichType.chickenTeriyaki);
      expect(sandwich.isFootlong, isTrue);
      expect(sandwich.breadType, BreadType.wheat);
    });

    test('name getter returns correct string for each type', () {
      // Assert
      expect(
          Sandwich(type: SandwichType.veggieDelight, isFootlong: false, breadType: BreadType.white).name,
          'Veggie Delight');
      expect(
          Sandwich(type: SandwichType.chickenTeriyaki, isFootlong: false, breadType: BreadType.white).name,
          'Chicken Teriyaki');
      expect(
          Sandwich(type: SandwichType.tunaMelt, isFootlong: false, breadType: BreadType.white).name,
          'Tuna Melt');
      expect(
          Sandwich(type: SandwichType.meatballMarinara, isFootlong: false, breadType: BreadType.white).name,
          'Meatball Marinara');
    });

    // A test for the 'image' getter can be added here
    // once its implementation is complete.
  });
}
