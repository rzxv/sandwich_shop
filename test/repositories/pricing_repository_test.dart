import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    final pricingRepository = PricingRepository();

    test('calculates price for a single six-inch sandwich', () {
      expect(pricingRepository.calculatePrice(quantity: 1, isFootlong: false), 7.0);
    });

    test('calculates price for a single footlong sandwich', () {
      expect(pricingRepository.calculatePrice(quantity: 1, isFootlong: true), 11.0);
    });

    test('calculates price for multiple six-inch sandwiches', () {
      expect(pricingRepository.calculatePrice(quantity: 3, isFootlong: false), 21.0);
    });

    test('calculates price for multiple footlong sandwiches', () {
      expect(pricingRepository.calculatePrice(quantity: 5, isFootlong: true), 55.0);
    });

    test('returns 0 for zero quantity', () {
      expect(pricingRepository.calculatePrice(quantity: 0, isFootlong: false), 0.0);
      expect(pricingRepository.calculatePrice(quantity: 0, isFootlong: true), 0.0);
    });
  });
}
