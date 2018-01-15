part of boardytale.heroes.model;

class Item {
  static List<String> itemTypes = const[
    "weapon",
    "helm",
    "gauntlet",
    "body",
    "boots",
    "ring",
    "amulet",
    "shield",
  ];
  String id = "noid";
  String name = "";
  String type = "weapon";
  Hero hero;
  num weight = 0;
  num armorPoints = 0;
  num healthBonus = 0;
  num manaBonus = 0;
  num strengthBonus = 0;
  num agilityBonus = 0;
  num intelligenceBonus = 0;
  num spiritualityBonus = 0;
  num precisionBonus = 0;
  num energyBonus = 0;

  Item() {}


  fromMap(Map data) {
    weight = data["weight"];
    manaBonus = data["manaBonus"];
    armorPoints = data["armorPoints"];
    healthBonus = data["healthBonus"];
    strengthBonus = data["strengthBonus"];
    agilityBonus = data["agilityBonus"];
    intelligenceBonus = data["intelligenceBonus"];
    spiritualityBonus = data["spiritualityBonus"];
    precisionBonus = data["precisionBonus"];
    energyBonus = data["energyBonus"];
    name = data["name"];
    id = data["id"].toString();
  }

  Map toMap() {
    return {
      'healthBonus': healthBonus,
      'manaBonus': manaBonus,
      'armorPoints': armorPoints,
      'weight': weight,
      'strengthBonus': strengthBonus,
      'intelligenceBonus': intelligenceBonus,
      'agilityBonus': agilityBonus,
      'spiritualityBonus': spiritualityBonus,
      'precisionBonus': precisionBonus,
      'energyBonus': energyBonus,
      'name': name,
      'id': id
    };
  }
}
