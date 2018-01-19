import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/components/heroes/edit_component.dart';
import 'package:boardytale_heroes/src/components/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/items/new_item_component.dart';
import 'package:boardytale_heroes/src/components/items/new_weapon_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'edit-shop',
  template: '''
  <div *ngIf="!shoppingMode">
    <h1>Nový obchod</h1>
    Jméno: <input [(ngModel)]="shopsService.selected.name"><br>
    Popis: <input [(ngModel)]="shopsService.selected.description"><br>
    
    <div *ngFor="let item of shopsService.selected.items">
    {{item.item.name}} - {{item.quantity == 0? "vyprodáno": item.quantity}}
    <button (click)="increaseQuantity(item, 1)">+</button>
    <button (click)="increaseQuantity(item, 10)">+10</button>
    <button (click)="increaseQuantity(item, 100)">+100</button>
    <button (click)="resetQuantity(item)">0</button>
    <button (click)="removeItem(item)">remove</button>
    
    Cena: <input type="number" [(ngModel)]="item.price" step="1" (change)="priceChanged()">
    </div>
    
    <button (click)="createShop()">{{shopsService.selected.id == null? "Vytvoř nový obchod": "Uprav obchod"}}</button>
    <button (click)="shoppingMode = !shoppingMode">Nákupní mód</button>
  </div>
  <div *ngIf="shoppingMode">
    <h1>{{shopsService.selected.name}}</h1>
    <p>{{shopsService.selected.description}}</p>
    <div class="card-deck">
      <div *ngFor="let item of shopsService.selected.items" class="item-preview col-4 item-tile">
        <div class="row">
         <div class="col-12">
          <div class="row">
              <div class="item-preview__requirements" class="col-8">
                <strong>{{item.item.name}} - {{item.item.getType()}}</strong><br>
                <span>Hmotnost: {{item.item.weight}}</span><br>
                <span *ngIf="item.item.type == 'weapon'">Body přesnosti: {{item.item.precision}}<br></span>
                <span *ngIf="item.item.type == 'weapon'">Efektivní s/o/i: {{item.item.effectiveStrength}} / {{item.item.effectiveAgility}} / {{item.item.effectiveIntelligence}}<br></span>
                <span *ngIf="item.item.type == 'weapon'">Základní útok: {{item.item.baseAttack}}<br></span>
                <button *ngIf="heroesService.selected != null" (click)="buy(item)">Koupit</button>
              </div>
              <div class="item-preview__bonuses" class="col-4">
                <strong>Bonusy:</strong><br>
                <span *ngIf="item.item.strengthBonus > 0">Síla: {{item.item.strengthBonus}}<br></span>
                <span *ngIf="item.item.agilityBonus > 0">Obratnost: {{item.item.agilityBonus}}<br></span>
                <span *ngIf="item.item.intelligenceBonus > 0">Inteligence: {{item.item.intelligenceBonus}}<br></span>
                <span *ngIf="item.item.armorPoints > 0">Body zbroje: {{item.item.armorPoints}}<br></span>
                <span *ngIf="item.item.manaBonus > 0">Bonusová mana: {{item.item.manaBonus}}<br></span>
                <span *ngIf="item.item.spiritualityBonus > 0">Bonusová spiritualita: {{item.item.spiritualityBonus}}<br></span>
                <span *ngIf="item.item.precisionBonus > 0">Bonusová preciznost: {{item.item.precisionBonus}}<br></span>
                <span *ngIf="item.item.energyBonus > 0">Bonusová energie: {{item.item.energyBonus}}<br></span>
              </div>
            </div>
            <div class="row">
               <div class="col-6">
                  <strong>Cena: {{item.price}}</strong>
               </div>
               <div class="col-6">
                  <strong>Kusů na skladě: {{item.quantity == 0? "vyprodáno": item.quantity}}</strong>
               </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <button (click)="shoppingMode = !shoppingMode">Editace obchodu</button>
  </div>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
  ],
)
class ShopsComponent {
  final ShopsService shopsService;
  final HeroesService heroesService;
  bool shoppingMode = true;

  ShopsComponent(
    this.shopsService,
    this.heroesService,
  );

  void createShop() {
    shopsService.createShop(shopsService.selected);
  }

  void removeItem(ShopItem item) {
    shopsService.selected.items.remove(item);
    shopsService.saveSelected();
  }

  void increaseQuantity(ShopItem item, int increaseQuantity) {
    item.quantity += increaseQuantity;
    shopsService.saveSelected();
  }

  void resetQuantity(ShopItem item) {
    item.quantity = 0;
  }

  void priceChanged() {
    shopsService.saveSelected();
  }

  void buy(ShopItem item) {
    if (heroesService.selected.money > item.price && item.quantity > 0) {
      heroesService.selected.money -= item.price;
      heroesService.selected.items.add(item.item);
      heroesService.saveSelected();
      item.quantity--;
      shopsService.saveSelected();
    }
  }
}
