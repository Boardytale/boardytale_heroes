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
  template: '''
    <button *ngIf="!createItemActive && !createWeaponActive" (click)="createItemActive = true">Vytvoř zbroj</button>
    <button *ngIf="!createItemActive && !createWeaponActive" (click)="createWeaponActive = true">Vytvoř zbraň</button>
    <button *ngIf="!createItemActive && !createWeaponActive" (click)="tableView = !tableView">{{tableView?"Dlaždice":"Tabulka"}}</button>
    <new-item *ngIf="createItemActive || itemIsEdited" (onNewItem)="onNewItem()"></new-item>
    <new-weapon *ngIf="createWeaponActive || weaponIsEdited" (onNewItem)="onNewItem()"></new-weapon>
    <div *ngIf="!tableView" class="card-deck">
      <item-preview *ngFor="let item of items" [item]="item"  class="col-4 item-tile"></item-preview>
    </div>
    <table *ngIf="tableView">
      <tr>
        <th>Název</th>
        <th>Typ</th>
        <th>Hmotnost</th>
        <th>Dop.cena</th>
        <th>Vyp.cena</th>
        <th>+Síla</th>
        <th>+Obr</th>
        <th>+Spirit</th>
        <th>+Energie</th>
        <th>+Preciznost</th>
        <th>Zbroj</th>
        <th>+HP</th>
        <th>+Mana</th>
        <th *ngIf="heroesService.selected != null"></th>
        <th *ngIf="shopsService.selected != null"></th>
        <th></th>
        <th></th>
      </tr>
      <tr *ngFor="let item of notWeapons" [ngClass]="{
      'bodyItem': item.type=='body',
      'boots': item.type=='boots',
      'jewels': item.type=='amulet'|| item.type =='ring'
      }">
       <td>{{item.name}}</td>
       <td>{{item.getType()}}</td>
        <td>{{item.weight}}</td>
        <td class="{{priceIsWrongClass(item)}}">{{item.suggestedPrice}}</td>
        <td>{{item.recommendedPrice}}</td>
        <td>{{item.strengthBonus}}</td>
        <td>{{item.agilityBonus}}</td>
        <td>{{item.spiritualityBonus}}</td>
        <td>{{item.energyBonus}}</td>
        <td>{{item.precisionBonus}}</td>
        <td>{{item.armorPoints}}</td>
        <td>{{item.healthBonus}}</td>
        <td>{{item.manaBonus}}</td>
        <td *ngIf="heroesService.selected != null" (click)="addToHero(item)" class="table-button">+h</td>
        <td *ngIf="shopsService.selected != null" (click)="addToShop(item)" class="table-button">+o</td>
        <td (click)="delete(item)" class="table-button">X</td>
        <td (click)="edit(item)" class="table-button">e</td>
      </tr>
    </table>
    
    <table *ngIf="tableView">
      <tr>
        <th>Název</th>
        
        <th>Útok</th>
        
        <th>Hmotnost</th>
        <th>Dop.cena</th>
        <th>Vyp.cena</th>
        <th>+Síla</th>
        <th>+Obr</th>
        <th>+Spirit</th>
        <th>+Energie</th>
        <th>+Preciz</th>
        <th>Zbroj</th>
        <th>+HP</th>
        <th>+Mana</th>
        <th *ngIf="heroesService.selected != null">+h</th>
        <th *ngIf="shopsService.selected != null"></th>
        <th></th>
        <th></th>
      </tr>
      <tr *ngFor="let item of weapons">
        <td>{{item.name}}</td>
       
        <td>{{item.baseAttack}}</td>
       
        <td>{{item.weight}}</td>
        <td class="{{priceIsWrongClass(item)}}">{{item.suggestedPrice}}</td>
        <td>{{item.recommendedPrice}}</td>
        <td>{{item.strengthBonus}}</td>
        <td>{{item.agilityBonus}}</td>
        <td>{{item.spiritualityBonus}}</td>
        <td>{{item.energyBonus}}</td>
        <td>{{item.precisionBonus}}</td>
        <td>{{item.armorPoints}}</td>
        <td>{{item.healthBonus}}</td>
        <td>{{item.manaBonus}}</td>
        <td *ngIf="heroesService.selected != null" (click)="addToHero(item)" class="table-button">+h</td>
        <td *ngIf="shopsService.selected != null" (click)="addToShop(item)" class="table-button">+o</td>
        <td (click)="delete(item)" class="table-button">X</td>
        <td (click)="edit(item)" class="table-button">e</td>
      </tr>
    </table>
  ''',
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
