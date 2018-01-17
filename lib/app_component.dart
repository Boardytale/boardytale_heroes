import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/heroes/heroes_component.dart';
import 'package:boardytale_heroes/src/components/items/items_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    ItemsComponent,
    HeroesComponent,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES
  ],
  providers: const [
    materialProviders,
    ItemsService,
    AuthService,
    HeroesService,
  ],
)
class AppComponent implements OnInit {
  AuthService authService;
  final HeroesService heroesService;
  List<Hero> heroes = [];
  bool dropDownOpened = false;

  AppComponent(this.authService,
      this.heroesService,);

  @override
  Future<Null> ngOnInit() async {
    authService.onUserData.stream.listen((_) async {
      Stream<List<Hero>> heroesData = await this.heroesService.getHeroes();
      heroesData.listen((List<Hero> heroes) {
        this.heroes = heroes;
      });
    });
  }

  void login() {
    authService.login();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }

  void create() {
    heroesService.selected = new Hero();
  }
}
