import 'package:angular/src/core/metadata.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:boardytale_heroes/src/components/shared/buttoned_number_input_component.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'edit-hero',
  templateUrl: 'edit_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
    ButtonedNumberInputComponent
  ]
)
class EditHeroComponent {
  @Input()
  Hero hero = new Hero();

  HeroesService heroService;

  EditHeroComponent(this.heroService);

  void save() {
    this.heroService.createOrEditHero(hero);
  }

  void removeWeapon() {
    hero.items.removeWhere((Item item) => item is Weapon);
    save();
  }

  void sellItem(Item item) {
    hero.items.removeWhere((Item value) => value == item);
    hero.money += (item.suggestedPrice / 2).floor();
    save();
  }
}
