import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/heroes/edit_component.dart';
import 'package:boardytale_heroes/src/components/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'heroes',
  template: '''
  <button (click)="create()">nový hrdina</button>
  <div 
  *ngFor="let hero of heroes"
  [ngClass]="{'selected': heroesService.selected == hero}"
  (click)="selectHero(hero)"
  class="hero-button">
    {{hero.name}}
  </div>
  <edit-hero *ngIf="heroesService.selected != null" [hero]="heroesService.selected"></edit-hero>
  ''',
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
  final ItemsService itemsService;
  final HeroesService heroesService;
  List<Hero> heroes = [];

  HeroesComponent(
    this.itemsService,
    this.heroesService,
  );

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Hero>> heroesData = await this.heroesService.getHeroes();
    heroesData.listen((List<Hero> heroes) {
      this.heroes = heroes;
    });
  }

  void create() {
//    editActive = true;
//    heroesService.createHero(hero);
    heroesService.selected = new Hero();
  }

  void selectHero(Hero hero) {
    heroesService.selected = hero;
  }
}
