part of boardytale.heroes.model;

class HeroState {
  Hero hero;
  num strength = 1;
  num agility = 1;
  num intelligence = 1;
  num bodyWeight = 55;
  num weight = 55;
  num level = 0;
  int precision = 0;
  num baseHealth = 0;
  num armorHealth = 0;
  int armorPoints = 0;
  num unflooredArmorPoints = 0;
  num strengthOnHeightArmor = 0;
  num agilityOnHeightArmor = 0;
  num speedPoints = 1;
  num speedPrecisionPoints = 0;
  num precisionPoints = 0;
  num unusedPrecisionPoints = 0;
  int itemWeight = 0;
  num damage = 1;
  num dmgPoints = 0;
  num suitability = 1;
  num usability = 1;
  num armor = 0;
  num speed = 1;
  List<int> attack = [0, 0, 0, 0, 0, 0];
  num health;
  num efficiency = 1;

  HeroState(this.hero) {
    ItemSum items = hero.getItemSum();
    strength = hero.strength + items.strengthBonus;
    agility = hero.agility + items.agilityBonus;
    intelligence = hero.intelligence + items.intelligenceBonus;
    bodyWeight = 55 + hero.strength * 3;
    itemWeight = items.weight;
    weight = bodyWeight + items.weight;
    level = (pow(hero.experience, 0.65) / 4).floor();
    baseHealth = 6 + (strength / 2).floor();

    recalculateArmor(items);

    health = baseHealth + armorHealth + items.healthBonus;

    recalculateSpeed();
    recalculateAttack();
  }

  void recalculateArmor(ItemSum items) {
    strengthOnHeightArmor =
        strength * 20 * max(items.armorPoints, 0.5) / weight;
    agilityOnHeightArmor = agility / pow(weight / 50, 2.2);
    unflooredArmorPoints =
        pow(strengthOnHeightArmor + agilityOnHeightArmor, 0.8);
    armorPoints = unflooredArmorPoints.floor();
    armorHealth = armorPoints;
    if (armorHealth > 7) {
      armor = 4;
      armorHealth -= 8;
    } else if (armorHealth > 5) {
      armor = 3;
      armorHealth -= 6;
    } else if (armorHealth > 3) {
      armor = 2;
      armorHealth -= 4;
    } else if (armorHealth > 1) {
      armor = 1;
      armorHealth -= 2;
    } else {
      armor = 0;
    }
  }

  recalculateSpeed() {
    var a = 15;
    var b = 1.5;
    var c = 2;
    var d = 2.9;
    var weight = this.weight - 30;
    var points = log(a * strength / weight +
            b * pow(strength, 2) * pow(agility, 2) / pow(weight, 2) +
            c) *
        d;
    speedPoints = points;
    var stops = [1, 2, 3, 4, 5, 6, 7];
    var i = 0;
    while (stops[i] < points) {
      i++;
    }
    speed = i;
    speedPrecisionPoints = points - stops[i - 1];
  }

  recalculateAttack() {
    double pp;
    double dmg;
    List<int> mask;
    Weapon weapon = hero.getWeapon();
    if (weapon != null) {
      num intelligenceDistance = null;
      num strengthDistance = null;
      num agilityDistance;

      if (weapon.effectiveIntelligence > intelligence) {
        num iPoint1 = intelligence;
        num iPoint2 = weapon.effectiveStrength *
            intelligence /
            weapon.effectiveIntelligence;
        num iPoint3 = weapon.effectiveAgility *
            intelligence /
            weapon.effectiveIntelligence;
        intelligenceDistance =
            sqrt(pow(iPoint1, 2) + pow(iPoint2, 2) + pow(iPoint3, 2));
      }

      if (weapon.effectiveStrength > strength) {
        num iPoint1 = strength;
        num iPoint2 =
            weapon.effectiveStrength * strength / weapon.effectiveStrength;
        num iPoint3 =
            weapon.effectiveAgility * strength / weapon.effectiveStrength;
        intelligenceDistance =
            sqrt(pow(iPoint1, 2) + pow(iPoint2, 2) + pow(iPoint3, 2));
      }

      if (weapon.effectiveAgility > agility) {
        num iPoint1 = agility;
        num iPoint2 =
            weapon.effectiveStrength * agility / weapon.effectiveAgility;
        num iPoint3 =
            weapon.effectiveAgility * agility / weapon.effectiveAgility;
        intelligenceDistance =
            sqrt(pow(iPoint1, 2) + pow(iPoint2, 2) + pow(iPoint3, 2));
      }

      num fullDistance = sqrt(pow(weapon.effectiveAgility, 2) +
          pow(weapon.effectiveStrength, 2) +
          pow(weapon.effectiveIntelligence, 2));

      if (intelligenceDistance != null) {
        efficiency = intelligenceDistance / fullDistance;
      }

      if (strengthDistance != null &&
          efficiency > strengthDistance / fullDistance) {
        efficiency = strengthDistance / fullDistance;
      }

      if (agilityDistance != null &&
          efficiency > agilityDistance / fullDistance) {
        efficiency = agilityDistance / fullDistance;
      }

      pp = weapon.precision.toDouble();
      mask = weapon.mask;
      dmg = weapon.damage.toDouble() * efficiency;
    } else {
      pp = 0.0;
      mask = [0, 1, 1, 1, 1, 1];
      dmg = 1.0 + strength / 7;
    }
    pp += (speedPrecisionPoints * 3).toDouble();
    pp *= agility / strength;
    precisionPoints = pp;
    precision = 1;
    if (pp > 25) {
      precision = 5;
      pp -= 25;
    } else if (pp > 8) {
      precision = 4;
      pp -= 8;
    } else if (pp > 4) {
      precision = 3;
      pp -= 4;
    } else if (pp > 1) {
      precision = 2;
      pp -= 1;
    }
    unusedPrecisionPoints = pp;
    pp = sqrt(pp).floor().toDouble();
    dmg = dmg.floor().toDouble();

    attack = [0, 0, 0, 0, 0, 0];

    int maskSum = 0;
    int prec = precision;
    for (var i = 0; i < prec; i++) {
      maskSum += mask[5 - i];
    }
    if (maskSum == 0) {
      maskSum = 6;
      mask = [1, 1, 1, 1, 1, 1];
    }
    var normask = [0, 0, 0, 0, 0, 0];
    for (var i = 0; i < 6; i++) {
      if (i > 5 - prec) {
        normask[i] = mask[i] ~/ maskSum;
      }
    }
    for (int i = 0; i < attack.length; i++) {
      attack[i] = (dmg * normask[i]).floor();
      if (attack[i] == 0 && normask[i] > 0) {
        attack[i] = 1;
      }
    }
    int sum = 0;
    for (int i = 0; i < attack.length; i++) {
      sum += attack[i];
    }
    for (int i = 0; i < dmg - sum; i++) {
      attack[5 - i%5]++;
    }
    damage = dmg;
    attack = attack;
  }
}
