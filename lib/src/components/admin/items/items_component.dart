import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/admin/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/admin/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'items',
  templateUrl: 'items_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    NewItemComponent,
    NewWeaponComponent,
    ItemPreviewComponent
  ],
)
class ItemsComponent implements OnInit {
  final ItemsService itemsService;
  final HeroesService heroesService;
  final ShopsService shopsService;
  List<Item> items = [];

  List<Item> get notWeapons =>
      items.where((Item item) => item is! Weapon).toList();

  List<Item> get weapons => items.where((Item item) => item is Weapon).toList();
  bool createItemActive = false;
  bool createWeaponActive = false;
  bool tableView = true;

  bool get weaponIsEdited => itemsService.editingItem is Weapon;

  bool get itemIsEdited =>
      itemsService.editingItem != null && itemsService.editingItem is! Weapon;

  ItemsComponent(
    this.itemsService,
    this.heroesService,
    this.shopsService,
  );

  void onNewItem() {
    createItemActive = false;
    createWeaponActive = false;
  }

  String priceIsWrongClass(Item item) {
    int diff = item.suggestedPrice - item.recommendedPrice;
    if (diff < 0) diff *= -1;
    return diff / (item.recommendedPrice + 0.001) > 0.5 ? "price_is_wrong" : "";
  }

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Item>> itemsData = await this.itemsService.getItems();
    itemsData.listen((List<Item> items) {
      this.items = items;
    });
  }

  void addToHero(Item item) {
    heroesService.selected.items.add(item);
    heroesService.createOrEditHero(heroesService.selected);
  }

  void addToShop(Item item) {
    ShopItem shopItem = shopsService.selected.items
        .firstWhere((ShopItem shopItem) => shopItem.item == item, orElse: () {
      ShopItem newItem = new ShopItem()
        ..quantity = 0
        ..item = item
        ..price = item.suggestedPrice
      ;
      shopsService.selected.items.add(newItem);
      return newItem;
    });
    shopItem.quantity++;
    shopsService.createShop(shopsService.selected);
  }

  void delete(Item item) {
    itemsService.delete(item);
  }

  void edit(Item item) {
    itemsService.editingItem = item;
  }
}
