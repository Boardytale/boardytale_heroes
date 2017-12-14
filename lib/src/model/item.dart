part of boardytale.heroes.model;

class Item {
  int id = 0;
  String name = "";
  Hero hero;
  num weight = 0;
  num armor = 0;
  num health = 0;
  num mana = 0;
  num strength = 0;
  num agility = 0;
  num intelligence = 0;

  Item() {}

  fromMap(Map data) {
    weight = data["weight"];
    mana = data["mana"];
    armor = data["armor"];
    health = data["health"];
    strength = data["strength"];
    agility = data["agility"];
    intelligence = data["intelligence"];
    name = data["name"];
    id = data["id"];
  }

  Map toMap() {
    return {
      'health': health,
      'mana': mana,
      'armor': armor,
      'weight': weight,
      'strength': strength,
      'intelligence': intelligence,
      'agility': agility,
      'name': name,
      'id': id
    };
  }
}

class Weapon extends Item {
  int requirePrecision = 0;
  int requireEnergy = 0;
  int requireDarkness = 0;
  int requireLevel = 0;
  int damage = 1;
  int precision = 1;
  int strengthUse = 1;
  int intelligenceUse = 1;
  int agilityUse = 1;
  int darknessUse = 1;
  int energyUse = 1;
  int precisionUse = 1;
  double physicalImpact = 1.0;
  double mysticalImpact = 0.2;
  double impactedUsabilityMatch = 0.0;
  double impactedSuitabilityMatch = 0.0;
  double suitabilityMatch = 0.0;
  double usabilityMatch = 0.0;
  List<int> mask = [1, 1, 1, 1, 1, 1];

  Weapon();

  void recalculate() {
    suitabilityMeasure();
    usabilityMeasure();
  }

  bool isSuitable(Hero hero) {
    if (requirePrecision > hero.data.precision) return false;
    if (requireEnergy > hero.data.energy) return false;
    if (requireDarkness > hero.data.darkness) return false;
    return true;
  }

  void fromMap(Map data) {
    requireDarkness = data["reqDarkness"];
    requireEnergy = data["reqEnergy"];
    requireLevel = data["reqLevel"];
    requirePrecision = data["reqPrecision"];
    damage = data["damage"];
    precision = data["precision"];
    strengthUse = data["strengthUse"];
    agilityUse = data["agilityUse"];
    intelligenceUse = data["intelligenceUse"];
    energyUse = data["energyUse"];
    darknessUse = data["darknessUse"];
    precisionUse = data["precisionUse"];
    physicalImpact = data["physicalImpact"];
    mysticalImpact = data["mysticalImpact"];
    impactedSuitabilityMatch = data["impactedSuitabilityMatch"];
    impactedUsabilityMatch = data["impactedUsabilityMatch"];
    suitabilityMatch = data["suitabilityMatch"];
    usabilityMatch = data["usabilityMatch"];
    mask = data["mask"];
  }

  Map toMap() {
    Map out = super.toMap();
    out.addAll({
      'reqDarkness': requireDarkness,
      'reqEnergy': requireEnergy,
      'reqLevel': requireLevel,
      'reqPrecision': requirePrecision,
      'damage': damage,
      'precision': precision,
      'strengthUse': strengthUse,
      'agilityUse': agilityUse,
      'intelligenceUse': intelligenceUse,
      'energyUse': energyUse,
      'darknessUse': darknessUse,
      'precisionUse': precisionUse,
      'physicalImpact': physicalImpact,
      'mysticalImpact': mysticalImpact,
      'impactedSuitabilityMatch': impactedSuitabilityMatch,
      'impactedUsabilityMatch': impactedUsabilityMatch,
      'suitabilityMatch': suitabilityMatch,
      'usabilityMatch': usabilityMatch,
      'mask': mask
    });
    return out;
  }

  Point<int> transform(a, b, c) {
    var x = 0;
    var y = 0;
    var sac = a + c;
    var x1 = (c / sac) / 2;

    // z rovnice přímky ac
    var y1 = -sqrt(3) * x1 + sqrt(3 / 4);

    // z rovnice přímky kolmé k ac
    var n2 = -sqrt(1 / 3) * x1 + y1;

    // konkrétní přímka odpovídající poměru a kolmá k ac má rovnici y= Math.sqrt(1/3)*x + n2

    var sbc = b + c;
    var x3 = b / sbc * 0.5 + 0.5;
    var y3 = sqrt(3) * x3 - sqrt(3 / 4);

    // z rovnice přímky kolmé k bc
    var n4 = sqrt(1 / 3) * x3 + y3;

    // konkrétní přímak odpovídající poměru a kolmá k bc má rovnici y = -Math.sqrt(1/3)*x+ n4

    y = (n2 + n4) ~/ 2;
    x = (y - n2) ~/ sqrt(1 / 3);
    return new Point(x, y);
  }

  void suitabilityMeasure() {
    var hgrid = transform(hero.data.precision, hero.data.energy, hero.data.darkness);
    var igrid = transform(precisionUse, energyUse, darknessUse);

    suitabilityMatch = sqrt(pow(hgrid.x - igrid.x, 2) + pow(hgrid.y - igrid.y, 2));
    impactedSuitabilityMatch = (suitabilityMatch * mysticalImpact);
  }

  void usabilityMeasure() {
    var hgrid = transform(hero.calculated.strength, hero.calculated.agility, hero.calculated.intelligence);
    var igrid = transform(strengthUse, agilityUse, intelligenceUse);
    usabilityMatch = sqrt(pow(hgrid.x - igrid.x, 2) + pow(hgrid.y - igrid.y, 2));
    impactedUsabilityMatch = usabilityMatch * physicalImpact;
  }
}
