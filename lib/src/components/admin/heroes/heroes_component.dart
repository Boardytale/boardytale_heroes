import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/admin/heroes/edit_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';

@Component(
  selector: 'heroes',
  template: '''
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
class HeroesComponent {
  final HeroesService heroesService;
  HeroesComponent(
    this.heroesService,
  );
}
