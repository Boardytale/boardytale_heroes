import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/components/admin/heroes/heroes_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/items_component.dart';
import 'package:boardytale_heroes/src/components/admin/nav/nav_component.dart';
import 'package:boardytale_heroes/src/components/admin/shops/shop_component.dart';
import 'package:boardytale_heroes/src/components/shared/buttoned_number_input_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'admin-component',
  templateUrl: 'admin_component.html',
  directives: const [
    CORE_DIRECTIVES,
    AdminNavComponent,
    ItemsComponent,
    HeroesComponent,
    ShopsComponent,
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
class AdminComponent implements OnInit {
  final ShopsService shopsService;
  final HeroesService heroesService;
  AuthService authService;
  List<Hero> heroes = [];
  List<Shop> shops = [];
  bool itemsVisible = true;

  AdminComponent(
    this.authService,
    this.heroesService,
    this.shopsService,
  );

  @override
  Future<Null> ngOnInit() async {
    authService.onUserData.stream.listen((_) async {
      Stream<List<Hero>> heroesData = await this.heroesService.getHeroes();
      heroesData.listen((List<Hero> heroes) {
        this.heroes = heroes;
      });

      Stream<List<Shop>> shopsData = await this.shopsService.getShops();
      shopsData.listen((List<Shop> shops) {
        this.shops = shops;
      });
    });
  }

  void createShop() {
    shopsService.selected = new Shop();
  }

  void selectShop(shop) {
    shopsService.selected = shop;
  }

  void create() {
    heroesService.selected = new Hero();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }
}
