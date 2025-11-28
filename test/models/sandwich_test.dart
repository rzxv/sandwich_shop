import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich', () {
    test('constructor assigns properties correctly', () {
      // Arrange
      const sandwich = Sandwich(
        type: SandwichType.teriyakiChicken,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      // Assert
      expect(sandwich.type, SandwichType.teriyakiChicken);
      expect(sandwich.isFootlong, isTrue);
      expect(sandwich.breadType, BreadType.wheat);
    });

    test('name getter returns correct string for each type', () {
      // Assert
      expect(
          Sandwich(type: SandwichType.veggieDelight, isFootlong: false, breadType: BreadType.white).name,
          'Veggie Delight');
      expect(
          Sandwich(type: SandwichType.teriyakiChicken, isFootlong: false, breadType: BreadType.white).name,
          'Teriyaki Chicken');
      expect(
          Sandwich(type: SandwichType.beefSpecial, isFootlong: false, breadType: BreadType.white).name,
          'Beef Special');
      expect(
          Sandwich(type: SandwichType.spicyItalian, isFootlong: false, breadType: BreadType.white).name,
          'Spicy Italian');
    });

    test('image getter returns correct path for footlong', () {
      // Arrange
      const sandwich = Sandwich(
        type: SandwichType.beefSpecial,
        isFootlong: true,
        breadType: BreadType.white,
      );

      // Assert
      expect(sandwich.image, 'assets/images/beefSpecial_footlong.png');
    });

    test('image getter returns correct path for six-inch', () {
      // Arrange
      const sandwich = Sandwich(
        type: SandwichType.spicyItalian,
        isFootlong: false,
        breadType: BreadType.white,
      );

      // Assert
      expect(sandwich.image, 'assets/images/spicyItalian_six_inch.png');
    });
  });
}
