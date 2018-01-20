import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'item-preview',
  template: '''
    <div class="item-preview">
      <div class="row">
        <div class="item-preview__requirements" class="col-8">
          <strong>{{item.name}} - {{item.getType()}}</strong><br>
          <span>Hmotnost: {{item.weight}}</span><br>
          <span>Doporučená cena: {{item.suggestedPrice}}</span><br>
          <span *ngIf="item.type == 'weapon'">Základní útok: {{item.baseAttack}}<br></span>
          <button (click)="delete()">Vymaž</button>
          <button (click)="edit()">Uprav</button>
          <button *ngIf="heroesService.selected != null" (click)="addToHero()">Přidej označenému hrdinovi</button>
          <button *ngIf="shopsService.selected != null" (click)="addToShop()">Přidej do vybraného obchodu</button>
        
        </div>
        <div class="item-preview__bonuses" class="col-4">
          <strong>Bonusy:</strong><br>
          <span *ngIf="item.strengthBonus > 0">Síla: {{item.strengthBonus}}<br></span>
          <span *ngIf="item.agilityBonus > 0">Obratnost: {{item.agilityBonus}}<br></span>
          <span *ngIf="item.intelligenceBonus > 0">Inteligence: {{item.intelligenceBonus}}<br></span>
          <span *ngIf="item.armorPoints > 0">Body zbroje: {{item.armorPoints}}<br></span>
          <span *ngIf="item.manaBonus > 0">Bonusová mana: {{item.manaBonus}}<br></span>
          <span *ngIf="item.spiritualityBonus > 0">Bonusová spiritualita: {{item.spiritualityBonus}}<br></span>
          <span *ngIf="item.precisionBonus > 0">Bonusová preciznost: {{item.precisionBonus}}<br></span>
          <span *ngIf="item.energyBonus > 0">Bonusová energie: {{item.energyBonus}}<br></span>
        </div>
      </div>
    </div>
  
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
)
class ItemPreviewComponent implements OnInit {
  ItemsService itemsService;
  HeroesService heroesService;
  ShopsService shopsService;
  List<Item> items = [];

  ItemPreviewComponent(
    this.itemsService,
    this.heroesService,
    this.shopsService,
  );

  @Input("item")
  Item item;

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }

  void delete() {
    itemsService.delete(item);
  }

  void edit() {
    itemsService.editingItem = item;
  }

  void addToHero() {
    heroesService.selected.items.add(item);
    heroesService.createOrEditHero(heroesService.selected);
  }

  void addToShop() {
    ShopItem shopItem = shopsService.selected.items
        .firstWhere((ShopItem item) => item.item == this.item, orElse: () {
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
}
