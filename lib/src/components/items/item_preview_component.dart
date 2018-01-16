import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'item-preview',
  template: '''
    <div class="item-preview">
      <div class="item-preview__requirements">
        <strong>{{item.name}} - {{item.getType()}}</strong><br>
        <span>Hmotnost: {{item.weight}}</span><br>
        <span *ngIf="item.type == 'weapon'">Body přesnosti: {{item.precision}}<br></span>
        <span *ngIf="item.type == 'weapon'">Efektivní s/o/i: {{item.effectiveStrength}} / {{item.effectiveAgility}} / {{item.effectiveIntelligence}}<br></span>
        <span *ngIf="item.type == 'weapon'">Základní útok: {{item.baseAttack}}<br></span>
        <button (click)="delete()">Vymaž</button>
        <button (click)="edit()">Uprav</button>
        <button *ngIf="heroesService.selected != null" (click)="addToHero()">Přidej označenému hrdinovi</button>
      
      </div>
      <div class="item-preview__bonuses">
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
  
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
)
class ItemPreviewComponent implements OnInit {
  ItemsService itemsService;
  HeroesService heroesService;
  List<Item> items = [];

  ItemPreviewComponent(this.itemsService, this.heroesService);

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
}
