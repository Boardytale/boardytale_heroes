import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/components/shared/buttoned_number_input_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'admin-nav-component',
  templateUrl: 'nav_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
    ButtonedNumberInputComponent
  ],
  providers: const [
    materialProviders,
    AuthService,
    HeroesService,
    ShopsService,
  ],
)
class AdminNavComponent implements OnInit {
  final ShopsService shopsService;
  final HeroesService heroesService;
  AuthService authService;
  List<Hero> heroes = [];

  AdminNavComponent(this.authService, this.heroesService, this.shopsService);

  @override
  Future<Null> ngOnInit() async {
    authService.onUserData.stream.listen((_) async {
      Stream<List<Hero>> heroesData = await this.heroesService.getHeroes();
      heroesData.listen((List<Hero> heroes) {
        this.heroes = heroes;
      });
    });
  }

  void toggled(bool open) {
    print("Dropdown is now: $open");
  }

  void login() {
    authService.login();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }
}
