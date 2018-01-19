import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/heroes/heroes_component.dart';
import 'package:boardytale_heroes/src/components/items/items_component.dart';
import 'package:boardytale_heroes/src/components/shops/shop_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    ItemsComponent,
    HeroesComponent,
    ShopsComponent,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    BS_DIRECTIVES,
  ],
  providers: const [
    materialProviders,
    ItemsService,
    AuthService,
    HeroesService,
    ShopsService,
  ],
)
class AppComponent implements OnInit {
  AuthService authService;
  final HeroesService heroesService;
  final ShopsService shopsService;
  List<Hero> heroes = [];
  bool dropDownOpened = false;
  List<Shop> shops = [];
  bool itemsVisible = false;

  AppComponent(
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

  void login() {
    authService.login();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }

  void create() {
    heroesService.selected = new Hero();
  }

  void toggled(bool open) {
    print("Dropdown is now: $open");
  }

  void createShop() {
    shopsService.selected = new Shop();
  }

  void selectShop(shop) {
    shopsService.selected = shop;
  }
}
