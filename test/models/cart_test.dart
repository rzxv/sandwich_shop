import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    final sandwich1 = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: false, // 6-inch
      breadType: BreadType.white,
    );
    final sandwich2 = Sandwich(
      type: SandwichType.chickenTeriyaki,
      isFootlong: true, // Footlong
      breadType: BreadType.wheat,
    );
    final sandwich1_variant = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: false, // 6-inch, same as sandwich1
      breadType: BreadType.wholemeal, // Different bread
    );

    setUp(() {
      cart = Cart();
    });

    test('initial state is empty', () {
      expect(cart.items, isEmpty);
      expect(cart.totalItemCount, 0);
      expect(cart.totalPrice, 0.0);
    });

    test('add new sandwich to cart', () {
      // Act
      cart.add(sandwich1);

      // Assert
      expect(cart.totalItemCount, 1);
      expect(cart.items.first.sandwich, sandwich1);
      expect(cart.items.first.quantity, 1);
    });

    test('add same sandwich multiple times increments quantity', () {
      // Act
      cart.add(sandwich1);
      cart.add(sandwich1, quantity: 2);

      // Assert
      expect(cart.totalItemCount, 3);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('add different sandwiches creates separate entries', () {
      // Act
      cart.add(sandwich1);
      cart.add(sandwich2);

      // Assert
      expect(cart.totalItemCount, 2);
      expect(cart.items.length, 2);
      expect(cart.items.map((e) => e.sandwich), containsAll([sandwich1, sandwich2]));
    });

    test('add different sandwich variants creates separate entries', () {
      // Act
      cart.add(sandwich1);
      cart.add(sandwich1_variant);

      // Assert
      expect(cart.totalItemCount, 2);
      expect(cart.items.length, 2);
    });

    test('remove sandwich from cart', () {
      // Arrange
      cart.add(sandwich1);
      cart.add(sandwich2);

      // Act
      cart.remove(sandwich1);

      // Assert
      expect(cart.totalItemCount, 1);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich, sandwich2);
    });

    test('clear empties the cart', () {
      // Arrange
      cart.add(sandwich1, quantity: 2);
      cart.add(sandwich2);

      // Act
      cart.clear();

      // Assert
      expect(cart.items, isEmpty);
      expect(cart.totalItemCount, 0);
      expect(cart.totalPrice, 0.0);
    });

    test('totalPrice is calculated correctly', () {
      // Arrange
      final pricingRepository = PricingRepository();
      cart.add(sandwich1, quantity: 2); // 2 x 6-inch Veggie
      cart.add(sandwich2, quantity: 1); // 1 x Footlong Chicken

      // Act
      final expectedPrice = pricingRepository.calculatePrice(quantity: 2, isFootlong: false) + pricingRepository.calculatePrice(quantity: 1, isFootlong: true);

      // Assert
      expect(cart.totalPrice, expectedPrice);
    });

    test('totalPrice is zero when cart is empty', () {
      expect(cart.totalPrice, 0.0);
    });

    test('totalPrice updates after removing an item', () {
      // Arrange
      final pricingRepository = PricingRepository();
      cart.add(sandwich1);
      cart.add(sandwich2);
      cart.remove(sandwich1);

      // Assert
      expect(cart.totalPrice, pricingRepository.calculatePrice(quantity: 1, isFootlong: true));
    });
  });
}
