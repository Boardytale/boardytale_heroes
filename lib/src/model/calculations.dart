part of boardytale.heroes.model;

class Calculations{
  static List<int> sumAttacks(List<int> a, List<int>b){
    return [a[0]+b[0],a[1]+b[1],a[2]+b[2],a[3]+b[3],a[4]+b[4],a[5]+b[5]];
  }
  static List<int> scaleAttack(List<int> attack, int scale){
    return [scale*attack[0],scale*attack[1],scale*attack[2],scale*attack[3],scale*attack[4],scale*attack[5]];
  }
  static List<int> capAttack(List<int> attack, List<int> cap){
    return [min(attack[0],cap[0]),min(attack[1],cap[1]),min(attack[2],cap[2]),min(attack[3],cap[3]),min(attack[4],cap[4]),min(attack[5],cap[5])];
  }
  static int levelForExperience(num experience) => (pow(experience, 0.65) / 4).floor();
  static int healthForStrength(int strength) => 6 + (strength / 2).floor();
  static num weightLimitForStrength(int strength) => 20*sqrt(strength);
  static int getEffectiveAgility(num heroAgility, num itemAgilityBonus,num itemWeight, num weightLimit) =>(heroAgility + itemAgilityBonus)*min(1,2-(itemWeight/weightLimit));
  static int getArmor(num effectiveAgility, num itemArmorBonus){
    num agilityArmor = 0.5*sqrt(effectiveAgility);
    return min(4.0,sqrt((agilityArmor*agilityArmor) + (itemArmorBonus*itemArmorBonus))).floor();
  }
  static int getSpeed(num itemWeight, num weightLimit)=> max(1,5-(2*itemWeight/weightLimit)).floor();
  static List<int> getDmgFromAttributes(int strength, int agility) {
    List<int> dmg = [0];

    num sumDmg = 1+((strength+agility)/8);
    num shift = 0.5;
    num atanShift = atan(shift);
    num coef = (atan(shift+(agility/8))-atanShift)/((PI/2)-atanShift);
    dmg.add((sumDmg*pow(coef,2.5)).floor());
    dmg.add((sumDmg*pow(coef,1.5)).floor());
    dmg.add((sumDmg*coef).floor());
    dmg.add(((strength/10)+(sumDmg)).floor());
    dmg.add(((strength/5)+(sumDmg)).floor());

    return dmg;
  }
  static List<int> getMaxAttackFromAttributes(int strength, int agility) {
    List<int> dmg = [0];

    num sumDmg = 1+((strength+agility)/8);
    num shift = 0.5;
    num atanShift = atan(shift);
    num coef = (atan(shift+(agility/8))-atanShift)/((PI/2)-atanShift);
    dmg.add((sumDmg*pow(coef,2.5)*3).floor());
    dmg.add((sumDmg*pow(coef,1.5)*3).floor());
    dmg.add((sumDmg*coef*3).floor());
    dmg.add((((strength/10)+(sumDmg))*3).floor());
    dmg.add((((strength/5)+(sumDmg))*3).floor());

    return dmg;
  }
}