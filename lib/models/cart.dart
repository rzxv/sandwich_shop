import 'package:sandwich_shop/repositories/pricing_repository.dart';

// Assuming sandwich.dart exists in lib/models/ and defines the Sandwich class
// with proper equality (==) and hashCode implementations.
import 'package:sandwich_shop/models/sandwich.dart';

/// A simple data class to represent an item in the shopping cart.
class CartItem {
  final Sandwich sandwich;
  final int quantity;

  const CartItem({required this.sandwich, required this.quantity});
}

/// Manages a collection of sandwich orders in a shopping cart.
class Cart {
  final PricingRepository _pricingRepository;
  final Map<Sandwich, int> _items = {};

  /// Creates a new Cart.
  ///
  /// An optional [pricingRepository] can be injected for testing.
  Cart({PricingRepository? pricingRepository})
      : _pricingRepository = pricingRepository ?? PricingRepository();

  /// A read-only list of the items currently in the cart.
  List<CartItem> get items {
    return _items.entries
        .map((entry) => CartItem(sandwich: entry.key, quantity: entry.value))
        .toList();
  }

  /// The total number of individual sandwiches in the cart.
  int get totalItemCount {
    if (_items.isEmpty) {
      return 0;
    }
    return _items.values.reduce((sum, quantity) => sum + quantity);
  }

  /// The total price of all items in the cart, calculated using [PricingRepository].
  double get totalPrice {
    return _items.entries.fold(0.0, (previousValue, entry) {
      final sandwich = entry.key;
      final quantity = entry.value;
      final itemPrice = _pricingRepository.calculatePrice(
        quantity: quantity,
        isFootlong: sandwich.isFootlong,
      );
      return previousValue + itemPrice;
    });
  }

  /// Adds a [sandwich] to the cart.
  ///
  /// If the exact same sandwich (based on type, size, and bread) already
  /// exists in the cart, its quantity is incremented by the given [quantity].
  /// Otherwise, a new entry is created.
  void add(Sandwich sandwich, {int quantity = 1}) {
    _items.update(
      sandwich,
      (existingQuantity) => existingQuantity + quantity,
      ifAbsent: () => quantity,
    );
  }

  /// Removes the entire entry for the given [sandwich] from the cart.
  void remove(Sandwich sandwich) {
    _items.remove(sandwich);
  }

  /// Empties the cart of all items.
  void clear() {
    _items.clear();
  }
}
