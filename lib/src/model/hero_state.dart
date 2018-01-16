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
  num unusedSpeedPointsHealth = 0;
  num unusedPrecisionHealth = 0;
  num armorPoints = 0;
  num unflooredArmorPoints = 0;
  num fatWeight = 0;
  num agilityArmorPoints = 0;
  num itemsArmorPoints = 0;
  num precisionOnAgilityAndStrength = 0;
  num speedPoints = 1;
  num precisionPoints = 0;
  int itemWeight = 0;
  num levelDamage = 0;
  num suitability = 1;
  num usability = 1;
  num armor = 0;
  num speed = 1;
  num mana = 0;
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
    mana = intelligence + items.manaBonus;
    recalculateArmor(items);
    recalculateSpeed();
    recalculateAttack();

    health = (baseHealth +
            armorHealth +
            items.healthBonus +
            unusedPrecisionHealth +
            unusedSpeedPointsHealth)
        .floor();
  }

  void recalculateArmor(ItemSum items) {
    fatWeight = weight / strength;
//        strength * 20 * max(items.armorPoints, 0.5) / weight;
    agilityArmorPoints = max(0, (5 * agility) - fatWeight);
    itemsArmorPoints = items.armorPoints;
    armorPoints = sqrt(itemsArmorPoints + agilityArmorPoints);
    armorHealth = armorPoints;
    if (armorHealth > 20) {
      armor = 4;
      armorHealth -= 20;
    } else if (armorHealth > 10) {
      armor = 3;
      armorHealth -= 10;
    } else if (armorHealth > 5) {
      armor = 2;
      armorHealth -= 3;
    } else if (armorHealth > 2) {
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
    speedPoints = log(a * strength / weight +
            b * pow(strength, 2) * pow(agility, 2) / pow(weight, 2) +
            c) *
        d;
    var stops = [1, 2, 3, 5, 9, 15, 25, 10000];
    var i = 0;
    while (stops[i] < speedPoints) {
      i++;
    }
    speed = i;
    unusedSpeedPointsHealth = speedPoints - stops[i - 1];
  }

  recalculateAttack() {
    Weapon weapon = hero.getWeapon();
    List<int> workingAttack = [0, 0, 0, 1, 1, 1];
    if (weapon != null) {
      workingAttack = weapon.baseAttack.toList();
      num intelligenceDistance = null;
      num strengthDistance = null;
      num agilityDistance = null;

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
        strengthDistance =
            sqrt(pow(iPoint1, 2) + pow(iPoint2, 2) + pow(iPoint3, 2));
      }

      if (weapon.effectiveAgility > agility) {
        num iPoint1 = agility;
        num iPoint2 =
            weapon.effectiveStrength * agility / weapon.effectiveAgility;
        num iPoint3 =
            weapon.effectiveAgility * agility / weapon.effectiveAgility;
        agilityDistance =
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
      precisionPoints = weapon.precision.toDouble();
    } else {
      precisionPoints = 1.0;
    }
    precisionOnAgilityAndStrength = 0;
    precisionOnAgilityAndStrength += agility;
    precisionOnAgilityAndStrength += 0.2 * strength;
    precisionOnAgilityAndStrength *= agility / strength;
    precisionPoints = sqrt(precisionPoints + precisionOnAgilityAndStrength);
    precision = 1;
    if (precisionPoints > 6) {
      precision = 5;
      precisionPoints -= 6;
    } else if (precisionPoints > 3) {
      precision = 4;
      precisionPoints -= 3;
    } else if (precisionPoints > 2) {
      precision = 3;
      precisionPoints -= 2;
    } else if (precisionPoints > 1) {
      precision = 2;
      precisionPoints -= 1;
    }
    unusedPrecisionHealth = precisionPoints;
    double unusedDamage =
        _applyWeaponEfficiency(workingAttack, efficiency).toDouble();
    // take damage on no precision positions
    for (var i = 0; i < 6 - precision; i++) {
      unusedDamage += workingAttack[i];
      workingAttack[i] = 0;
    }
    levelDamage = pow(level, 0.7);
    unusedDamage += levelDamage;

    // fill precision with priority
    for (var i = 6 - precision; i < 6; i++) {
      if(unusedDamage > 1 && workingAttack[i] == 0){
        workingAttack[i] = 1;
        unusedDamage--;
      }
    }

    // divine unused damage
    for (int i = 0; i < unusedDamage - 1; i++) {
      workingAttack[5 - i % precision]++;
    }
    attack = workingAttack;
  }

  double _applyWeaponEfficiency(List<int> baseAttack, double efficiency) {
    double out = 0.0;
    for (int i = 0; i < baseAttack.length; i++) {
      double reduced = baseAttack[i] * efficiency;
      out += reduced.remainder(1);
      baseAttack[i] = reduced.floor();
    }
    return out;
  }
}
