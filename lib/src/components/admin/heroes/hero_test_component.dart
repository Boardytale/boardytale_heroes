import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/admin/heroes/edit_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';

@Component(
  selector: 'hero-test',
  templateUrl: 'hero-test_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    EditHeroComponent
  ],
)
class TestHeroComponent implements OnInit {
  final HeroesService heroesService;
  final AuthService authService;
  List<Hero> heroes = [];

  Hero hero1;
  Hero hero2;
  HeroTest test;
  bool isCurrent = false;
  double win1ChanceFirst;
  double win2ChanceFirst;
  double win1ChanceSecond;
  double win2ChanceSecond;

  TestHeroComponent(
    this.authService,
    this.heroesService,
  );

  @override
  Future<Null> ngOnInit() async {
    authService.onUserData.stream.listen((_) async {
      Stream<List<Hero>> heroesData = await this.heroesService.getHeroes();
      heroesData.listen((List<Hero> heroes) {
        this.heroes = heroes;
      });
    });
  }

  void selectHero1(Hero hero) {
    hero1 = hero;
    isCurrent = false;
    if(hero2!=null)test = new HeroTest(hero1.getState(), hero2.getState());
  }

  void selectHero2(Hero hero) {
    hero2 = hero;
    isCurrent = false;
    if(hero1!=null)test = new HeroTest(hero1.getState(), hero2.getState());
  }

  void getTestResults(){
    win1ChanceFirst  = (test.getChance(0)*10000).round()/100;
    win1ChanceSecond = (test.getChance(1)*10000).round()/100;
    win2ChanceFirst  = 100.0 - win1ChanceFirst;
    win2ChanceSecond = 100.0 - win1ChanceSecond;
    isCurrent = true;
  }
}
