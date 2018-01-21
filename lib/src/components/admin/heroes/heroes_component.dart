import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/admin/heroes/edit_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';

@Component(
  selector: 'heroes',
  templateUrl: 'heroes_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    NewItemComponent,
    NewWeaponComponent,
    ItemPreviewComponent,
    EditHeroComponent
  ],
)
class HeroesComponent implements OnInit {
  final HeroesService heroesService;
  final AuthService authService;
  List<Hero> heroes = [];

  HeroesComponent(
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

  void create() {
    heroesService.selected = new Hero();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }
}
