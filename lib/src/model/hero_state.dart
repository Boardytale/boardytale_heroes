part of boardytale.heroes.model;

class HeroState {
  Hero hero;
  num effectiveStrength = 1;
  num effectiveAgility = 1;
  num _effectivePrecision = 1;
  num _effectiveEnergy = 1;
  num _effectiveSpirituality = 1;
  num level = 0;
  num baseHealth = 0;
  num weightLimit = 0;
  num itemsArmorPoints = 0;
  num speedPoints = 1;
  int itemWeight = 0;
  num armor = 0;
  num speed = 1;
  num mana = 0;
  num health;
  List<int> ownAttack = [0, 0, 0, 0, 0, 0];
  List<int> maxAttack = [0, 0, 0, 0, 0, 0];
  List<int> itemAttack = [0, 0, 0, 0, 0, 0];
  List<int> itemBonusAttack = [0, 0, 0, 0, 0, 0];
  List<int> attack = [0, 0, 0, 0, 0, 0];

  HeroState(this.hero) {
    ItemSum items = hero.getItemSum();
    itemWeight = items.weight;
    _effectivePrecision = hero.precision + items.precisionBonus;
    _effectiveEnergy = hero.energy + items.energyBonus;
    _effectiveSpirituality = hero.spirituality + items.spiritualityBonus;
    effectiveStrength = hero.strength + items.strengthBonus;
    weightLimit = Calculations.weightLimitForStrength(effectiveStrength);
    effectiveAgility = Calculations.getEffectiveAgility(hero.agility, items.agilityBonus, itemWeight, weightLimit);
    baseHealth = Calculations.healthForStrength(effectiveStrength);
    ownAttack = Calculations.getDmgFromAttributes(effectiveStrength, effectiveAgility);
    maxAttack = Calculations.getMaxAttackFromAttributes(effectiveStrength, effectiveAgility);
    level = Calculations.levelForExperience(hero.experience);
    armor = Calculations.getArmor(effectiveAgility, items.armorPoints);
    speed = Calculations.getSpeed(itemWeight, weightLimit);
    itemAttack = hero.getWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getWeapon().baseAttack;
    itemBonusAttack = hero.getWeapon() == null ? [0, 0, 0, 0, 0, 0] : hero.getWeapon().bonusAttack;
    attack = Calculations.sumAttacks(
        itemBonusAttack, Calculations.capAttack(Calculations.sumAttacks(ownAttack, itemAttack), maxAttack));
    health = baseHealth + items.healthBonus;
    mana = 10 * _effectiveEnergy + items.manaBonus;
  }
}
