part of boardytale.heroes.model;

class Weapon extends Item {
  static const String typeName = "weapon";
  num precision = 1;
  num effectiveStrength = 1;
  num effectiveIntelligence = 1;
  num effectiveAgility = 1;
  List<int> baseAttack = [0, 0, 0, 0, 0, 0];

  void fromMap(Map data) {
    super.fromMap(data);
    precision = data["precision"];
    if (data["effectiveStrength"] is num) {
      effectiveStrength = data["effectiveStrength"];
    }
    if (data["effectiveIntelligence"] is num) {
      effectiveIntelligence = data["effectiveIntelligence"];
    }
    if (data["effectiveAgility"] is num) {
      effectiveAgility = data["effectiveAgility"];
    }
    baseAttack = data["baseAttack"];
  }

  Map toMap() {
    Map out = super.toMap();
    out.addAll({
      'precision': precision,
      'effectiveStrength': effectiveStrength,
      'effectiveIntelligence': effectiveIntelligence,
      'effectiveAgility': effectiveAgility,
      'baseAttack': baseAttack
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
}
