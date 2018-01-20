import 'dart:math';
import 'dart:html';

main() {
  document.getElementById("tableCont").innerHtml = getTableString(20,20);
}
String getTableString(int maxStrength, int maxAgility){
  String str = "<table>";
  str += "<tr>";
  for(int a = 1; a<maxAgility+1;a++){
    str+= "<td>$a</td>";
  }
  str += "</tr>";

  for(int s=1;s<maxStrength+1;s++){
    str += "<tr>";
    for(int a = 0; a<maxAgility+1;a++){
      if(a==0)str+= "<td>$s</td>";
      if(a!=0)str+= "<td>${getDmgHtml(getDmg(s,a))}</td>";
    }
    str += "</tr>";
  }

  str+="</table>";
  return str;
}

List<int> getDmg(int strength, int agility) {
  num normStrength = strength / 4;
  num normAgility = agility / 8;

  List<int> dmg = [0];
  if (normStrength > normAgility) {
    dmg.add(normAgility.floor());
    dmg.add((pow(normAgility*normAgility*normStrength,1/3)).floor());
    dmg.add((pow(normAgility*normStrength*normStrength,1/3)).floor());
    dmg.add(normStrength.floor());
    dmg.add(normStrength.floor());
  }
  else{
    dmg.add(normStrength.floor());
    dmg.add((pow(normAgility*normStrength*normStrength,1/3)).floor());
    dmg.add((pow(normAgility*normAgility*normStrength,1/3)).floor());
    dmg.add(normAgility.floor());
    dmg.add(normAgility.floor());
  }

  return dmg;
}

String getDmgHtml(List<int> dmg){
  return "${dmg[0]} ${dmg[1]} ${dmg[2]} ${dmg[3]} ${dmg[4]} ";
}
