enum BreadType { white, wheat, wholemeal }

enum SandwichType { veggieDelight, teriyakiChicken, beefSpecial, spicyItalian }

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;

  const Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
  });

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.teriyakiChicken:
        return 'Teriyaki Chicken';
      case SandwichType.beefSpecial:
        return 'Beef Special';
      case SandwichType.spicyItalian:
        return 'Spicy Italian';
    }
  }

  String get image {
    String typeString = type.name;
    String sizeString = '';
    if (isFootlong) {
      sizeString = 'footlong';
    } else {
      sizeString = 'six_inch';
    }
    return 'assets/images/${typeString}_$sizeString.png';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sandwich &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          isFootlong == other.isFootlong &&
          breadType == other.breadType;

  @override
  int get hashCode => type.hashCode ^ isFootlong.hashCode ^ breadType.hashCode;
}
