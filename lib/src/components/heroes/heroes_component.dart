import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'heroes',
  template: '''

heroes
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    NewItemComponent,
    NewWeaponComponent,
    ItemPreviewComponent],
)
class HeroesComponent implements OnInit {
  final ItemsService itemsService;
  List<Item> items = [];
  bool createItemActive = false;
  bool createWeaponActive = false;

  HeroesComponent(this.itemsService);

  void onNewItem() {
    createItemActive = false;
    createWeaponActive = false;
  }

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Item>> itemsData = await this.itemsService.getItems();
    itemsData.listen((List<Item> items) {
      this.items = items;
    });
  }
}
