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
      </tr>
    </table>
    
    <table *ngIf="tableView">
      <tr>
        <th>Název</th>
        
        <th>Přesnost</th>
        <th>Efektivní s/o/i</th>
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
      </tr>
      <tr *ngFor="let item of weapons">
        <td>{{item.name}}</td>
       
        <td>{{item.precision}}</td>
        <td>{{item.effectiveStrength}} / {{item.effectiveAgility}} / {{item.effectiveIntelligence}}</td>
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

  ItemsComponent(this.itemsService);

  void onNewItem() {
    createItemActive = false;
    createWeaponActive = false;
  }

  String priceIsWrongClass(Item item){
    int diff = item.suggestedPrice - item.recommendedPrice;
    if(diff<0) diff*=-1;
    return diff/(item.recommendedPrice+0.001) > 0.5 ? "price_is_wrong":"";
  }

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Item>> itemsData = await this.itemsService.getItems();
    itemsData.listen((List<Item> items) {
      this.items = items;
    });
  }
}
