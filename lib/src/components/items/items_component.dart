import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'items',
  template: '''
    <button *ngIf="!createItemActive && !createWeaponActive" (click)="createItemActive = true">Vytvoř zbroj</button>
    <button *ngIf="!createItemActive && !createWeaponActive" (click)="createWeaponActive = true">Vytvoř zbraň</button>
    <new-item *ngIf="createItemActive || itemIsEdited" (onNewItem)="onNewItem()"></new-item>
    <new-weapon *ngIf="createWeaponActive || weaponIsEdited" (onNewItem)="onNewItem()"></new-weapon>
    <item-preview *ngFor="let item of items" [item]="item"></item-preview>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    NewItemComponent,
    NewWeaponComponent,
    ItemPreviewComponent],
)
class ItemsComponent implements OnInit {
  final ItemsService itemsService;
  List<Item> items = [];
  bool createItemActive = false;
  bool createWeaponActive = false;

  bool get weaponIsEdited => itemsService.editingItem is Weapon;
  bool get itemIsEdited => itemsService.editingItem != null && itemsService.editingItem is !Weapon;

  ItemsComponent(this.itemsService);

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
