part of boardytale.heroes.model;

class Hero {
  String id = "noid";
  String userId;
  String name = "";

  num strength = 1;
  int agility = 1;
//  num intelligence = 1;
  num precision = 10;
  num spirituality = 10;
  num energy = 10;
  num experience = 0;
  num money = 100;

//  HeroData data = new HeroData();
  List<Item> items = new List<Item>();
  List<Ability> abilities = new List<Ability>();
  HeroOut out = new HeroOut();
  HeroSettings settings = new HeroSettings();
  Weapon weapon = null;


  Hero() {
    recalc();
  }

  HeroState getState() {
    return new HeroState(this);
  }

  ItemSum getItemSum() {
    return new ItemSum()..addItems(items);
  }

  Weapon getWeapon() {
    return items.firstWhere((Item i) => i is Weapon, orElse: () => null);
  }

  addItem([String itemData]) {
    Item item = new Item();
    item.hero = this;
    if (itemData != null) {
      item.fromMap(null);
    }
    items.add(item);
    if (item is Weapon) {
      weapon = item;
    }
    recalc();
  }

  recalc() {
//    itemSum.reset();
//    for (Item item in items) {
//      itemSum.add(item);
//    }
////    calculated.takeBasic(this, itemSum);
//    calculated.recalculateArmor(itemSum, out);
//    calculated.recalculateSpeed(out);
//    out.mana =
//        calculated.intelligence + itemSum.manaBonus + itemSum.intelligenceBonus;
//    recalcAttack();
//    out.health = calculated.health;
  }

  Map<String, dynamic> toMap() {
    Map out = {};
    out["id"] = id;
    out["userId"] = userId;
    out["name"] = name;
    out["agility"] = agility;
    out["strength"] = strength;
//    out["intelligence"] = intelligence;
    out["spirituality"] = spirituality;
    out["energy"] = energy;
    out["precision"] = precision;
    out["items"] = items.map((Item i) => i.id).toList();
    out["money"] = money.toInt();
    return out;
  }

  void fromMap(Map<String, dynamic> data, ItemsService itemsService) {
    userId = data["userId"];
    name = data["name"];
    agility = data["agility"];
    if(agility<1){
      agility = 1;
    }
    strength = data["strength"];
    if(strength<1){
      strength = 1;
    }


    spirituality = data["spirituality"];
    if(spirituality<1){
      spirituality = 1;
    }
    energy = data["energy"];
    if(energy<1){
      energy = 1;
    }
    precision = data["precision"];
    if(precision<1){
      precision = 1;
    }
    if(data["money"] is int){
      money = data["money"];
    }

    List<String> itemsInput = data["items"];
    if (itemsInput == null) {
      itemsInput = [];
    }

    items.clear();
    itemsInput.forEach((String itemId) {
      itemsService.getItemById(itemId).then((Item item) {
        if(item != null){
          items.add(item);
        }
      });
    });

    // dirty data check
    if (agility == null) {
      agility = 1;
    }
    if (strength == null) {
      strength = 1;
    }
    if (spirituality == null) {
      spirituality = 1;
    }
    if (energy == null) {
      energy = 1;
    }
    if (precision == null) {
      precision = 1;
    }
  }
}

class HeroSettings {
  num expAditive = 1;
  String selectedTab = "#heroWidgetOverview";
  num lastLevelMinusUsedFyzical = 0;
  num lastLevelMinusUsedMystical = 0;

  HeroSettings();
}

class HeroOut {
  num health = 1;
  num mana = 1;
  num range = 0;
  num armor = 0;
  List<int> attack = [0, 0, 0, 1, 2, 3];
  num speed = 1;

  HeroOut();

  get shealth => health.toString();

  get attackString => attack.toString();

  operator [](item) {
    switch (item) {
      case "health":
        return health;
      case "mana":
        return mana;
      default:
        return armor;
    }
  }
}
