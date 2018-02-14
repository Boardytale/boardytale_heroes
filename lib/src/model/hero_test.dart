part of boardytale.heroes.model;

class HeroTest{
  HeroState _hero1;
  HeroState _hero2;
  //  who strikes first, hp of hero1, hp of hero2, probability of win1
  Map<int, Map<int, Map<int, double>>> partialResults = {};

  Map<int, double> damageChances1to2 = {};
  Map<int, double> damageChances2to1 = {};

  HeroTest inverseTest;

  HeroTest(this._hero1, this._hero2){
    if(_hero1.attack[0]>_hero1.attack[1])throw "wrong attack order";
    if(_hero1.attack[1]>_hero1.attack[2])throw "wrong attack order";
    if(_hero1.attack[2]>_hero1.attack[3])throw "wrong attack order";
    if(_hero1.attack[3]>_hero1.attack[4])throw "wrong attack order";

    if(_hero2.attack[0]>_hero2.attack[1])throw "wrong attack order";
    if(_hero2.attack[1]>_hero2.attack[2])throw "wrong attack order";
    if(_hero2.attack[2]>_hero2.attack[3])throw "wrong attack order";
    if(_hero2.attack[3]>_hero2.attack[4])throw "wrong attack order";

    int dmg = 0;
    int diceThrow = 1;
    while(dmg<_hero2.health){
      if(diceThrow%6 == 0)diceThrow++;
      dmg = max(0, getRawDamage(_hero1.attack, diceThrow)-_hero2.armor);
      double prob = getDiceThrowProbability(diceThrow);
      if(dmg>=_hero2.health){
        prob = 1.0 - damageChances1to2.values.reduce((a,b)=>a+b);
      }
      if(damageChances1to2[dmg]==null){damageChances1to2[dmg] = prob;}else{damageChances1to2[dmg] += prob;}
      diceThrow++;
    }

    dmg = 0;
    diceThrow = 1;
    while(dmg<_hero1.health){
      if(diceThrow%6 == 0)diceThrow++;
      dmg = max(0, getRawDamage(_hero2.attack, diceThrow)-_hero1.armor);
      double prob = getDiceThrowProbability(diceThrow);
      if(dmg>=_hero1.health){
        prob = 1.0 - damageChances2to1.values.reduce((a,b)=>a+b);
      }
      if(damageChances2to1[dmg]==null){damageChances2to1[dmg] = prob;}else{damageChances2to1[dmg] += prob;}
      diceThrow++;
    }
//    print(damageChances1to2);
//    print(damageChances2to1);
  }

  double getChance(int firstPlayer){
    if(firstPlayer==0)return getProbability(0, _hero1.health, _hero2.health);
    if(firstPlayer==1){
      if(inverseTest==null)inverseTest=new HeroTest(_hero2, _hero1);
      return 1.0-inverseTest.getProbability(0, _hero2.health, _hero1.health);
    }
    throw "wierd firdt player";
  }

  double getSavedProbability(int firstPlayer, int hp1, int hp2){
    if(partialResults[firstPlayer]==null)return null;
    if(partialResults[firstPlayer][hp1]==null)return null;
    if(partialResults[firstPlayer][hp1][hp2]==null)return null;
    return partialResults[firstPlayer][hp1][hp2];
  }

  double getProbability(int firstPlayer, int hp1, int hp2){
    double toReturn = getSavedProbability(firstPlayer, hp1, hp2);
    if(toReturn == null)toReturn = calculateProbability(firstPlayer, hp1, hp2);
    return toReturn;
  }

  double calculateProbability(int firstPlayer, int hp1, int hp2) {
//    if(hp1<1)return 0.0;
//    if(hp2<1)return 1.0;
    if(hp2<1 && hp1<1)throw "oops";
    print("First player: $firstPlayer, hp1: $hp1, hp2: $hp2");
    double nullDamageChance = damageChances1to2[0]*damageChances2to1[0];
    double kill1To2Chance = damageChances1to2.keys.fold(0.0, (prob, key)=>(key>=hp2) ? prob+damageChances1to2[key] : prob);
//    double kill2To1Chance = damageChances2to1.keys.fold(0.0, (prob, key)=>(key>=hp2) ? prob+damageChances2to1[key] : prob);
//    double chanceToWin2Now = kill2To1Chance*(1.0-kill1To2Chance);
    double chanceToWin1Later = 0.0;
    double chanceToWin2Later = 0.0;

    for(int dmg1 = 0; dmg1<hp2; dmg1++){
      if(damageChances1to2[dmg1]!=null)for(int dmg2 = 0; dmg2<hp1; dmg2++){
        if(damageChances2to1[dmg2]!=null){
          if(!(dmg1==0&&dmg2==0)){
            double prob = getProbability(firstPlayer, hp1-dmg2, hp2-dmg1);
            chanceToWin1Later += damageChances1to2[dmg1]*damageChances2to1[dmg2]*prob;
            chanceToWin2Later += damageChances1to2[dmg1]*damageChances2to1[dmg2]*(1.0-prob);
          }
        }
      }
    }

    print("($hp1/$hp2) chanceToWin2Later: $chanceToWin2Later, chanceToWin1Later: $chanceToWin1Later, kill1To2Chance: $kill1To2Chance, nullDamageChance: $nullDamageChance");
    double toReturn = (chanceToWin1Later+kill1To2Chance)/(1.0-nullDamageChance);
    saveProbability(firstPlayer, hp1, hp2, toReturn);
    return toReturn;
  }

  void saveProbability(int firstPlayer, int hp1, int hp2, double win1probability) {
    if(partialResults[firstPlayer]==null)partialResults[firstPlayer]={};
    if(partialResults[firstPlayer][hp1]==null)partialResults[firstPlayer][hp1] = {};
    if(partialResults[firstPlayer][hp1][hp2]==null)partialResults[firstPlayer][hp1][hp2] = win1probability;
  }

  int getRawDamage(List<int> attack, int diceThrow){
    if(diceThrow<7)return attack[diceThrow-1];
    int overThrow = diceThrow-6;
    return attack[5]+overThrow;
  }

  double getDiceThrowProbability(int diceThrow){
    int throws = (diceThrow/6.0).ceil();
    return pow(6,-throws);
  }
}