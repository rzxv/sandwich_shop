class PricingRepository {
  double calculatePrice({required int quantity, required bool isFootlong}) {
    double price = isFootlong ? 11.0 : 7.0;
    return price * quantity;
  }
}
