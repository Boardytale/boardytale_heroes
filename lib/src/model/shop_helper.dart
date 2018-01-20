part of boardytale.heroes.model;

class ShopHelper {
  static const double weightHalfPoint = 25.0;
  static const double attributePrice = 20.0;
  static const double effectiveAttributePrice = 10.0;
  static const double armorPointPrice = 25.0;
  static const double healthBonusPrice = 10.0;
  static const double manaBonusPrice = 20.0;
  static const double strengthBonusPrice = attributePrice;
  static const double agilityBonusPrice = attributePrice;
  static const double intelligenceBonusPrice = attributePrice;
  static const double spiritualityBonusPrice = attributePrice;
  static const double precisionBonusPrice = attributePrice;
  static const double energyBonusPrice = attributePrice;

  static const double effectiveStrengthPrice = effectiveAttributePrice;
  static const double effectiveAgilityPrice = effectiveAttributePrice;
  static const double effectiveIntelligencePrice = effectiveAttributePrice;
  static const double attackPrice = 15.0;
  static const double index1AttackPrice = 8.0* attackPrice;
  static const double index2AttackPrice = 4.0* attackPrice;
  static const double index3AttackPrice = 2.0* attackPrice;
  static const double index4AttackPrice = 1.0* attackPrice;
  static const double index5AttackPrice = 1.0 * attackPrice;

  static const double priceProgression = 2.0;

  static const Map<String, double> typeCoefficients = const {
    "weapon": 1.0,
    "helm": 1.3,
    "gauntlet": 2.0,
    "body": 0.8,
    "boots": 1.2,
    "ring": 5.0,
    "amulet": 4.0,
    "shield": 1.2
  };

  static int recommendPrice(Item item) {
    double bonusPrice = item.armorPoints * armorPointPrice +
        item.healthBonus * healthBonusPrice +
        item.manaBonus * manaBonusPrice +
        item.strengthBonus * strengthBonusPrice +
        item.agilityBonus * agilityBonusPrice +
        item.intelligenceBonus * intelligenceBonusPrice +
        item.spiritualityBonus * spiritualityBonusPrice +
        item.precisionBonus * precisionBonusPrice +
        item.energyBonus * energyBonusPrice;
    double weaponPrice = 0.0;
    if (item is Weapon) {
      weaponPrice += _recommendWeaponPrice(item);
    }
    double weightCoefficient = _weightCoefficient(item);
    double price = (bonusPrice + weaponPrice) * weightCoefficient;
    int roundedProgressedPrice =_roundPrice( pow(price / 100, priceProgression) * 100.0);
    print("${item.name} - ($bonusPrice + $weaponPrice) * $weightCoefficient => $price => $roundedProgressedPrice");
    return roundedProgressedPrice;
  }

  static double _recommendWeaponPrice(Weapon weapon) {
    double effectivePrice = weapon.effectiveAgility * effectiveAgilityPrice +
        weapon.effectiveStrength * effectiveStrengthPrice +
        weapon.effectiveIntelligence * effectiveIntelligencePrice;
    double effectiveCoefficient = 1000 / (effectivePrice + 1000);
    double price = weapon.baseAttack[1] * index1AttackPrice +
        weapon.baseAttack[2] * index2AttackPrice +
        weapon.baseAttack[3] * index3AttackPrice +
        weapon.baseAttack[4] * index4AttackPrice +
        weapon.baseAttack[5] * index5AttackPrice;
    print("${weapon.name} (${weapon.baseAttack}) - $price * $effectiveCoefficient => ${price*effectiveCoefficient}");
    return price * effectiveCoefficient;
  }

  static double _weightCoefficient(Item item) {
    double weightCoefficient = 1 / (1 + item.weight / weightHalfPoint);
    double typeCoefficient = typeCoefficients[item.type] ?? 1.0;
    return weightCoefficient * typeCoefficient;
  }

  static int _roundPrice(double price) {
    if(price == 0){
      price = 0.01;
    }
    int places = (log(price) / LN10).floor();
    int divider = 1;
    if (places <= 0) return 1;
    divider = pow(10, places - 1).floor();
    return (price / divider).round() * divider;
  }
}
