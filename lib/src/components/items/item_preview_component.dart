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
        <strong>{{item.name}} - {{item.type}}</strong><br>
        <span>Hmotnost: {{item.weight}}</span><br>
        <span *ngIf="item.type == 'weapon'">Útočnost: {{item.damage}}</span><br>
        <span *ngIf="item.type == 'weapon'">Rozsah útoku: {{item.precision}}</span><br>
        <span *ngIf="item.type == 'weapon'">Efektivní síla: {{item.effectiveStrength}}</span><br>
        <span *ngIf="item.type == 'weapon'">Efektivní obratnost: {{item.effectiveAgility}}</span><br>
        <span *ngIf="item.type == 'weapon'">Efektivní inteligence: {{item.effectiveIntelligence}}</span><br>
        <span *ngIf="item.type == 'weapon'">Maska útoku: {{item.mask}}</span><br>
        <button (click)="delete()">Vymaž</button>
        <button (click)="edit()">Uprav</button>
        <button *ngIf="heroesService.selected != null" (click)="addToHero()">Přidej označenému hrdinovi</button>
      
      </div>
      <div class="item-preview__bonuses">
        <strong>Bonusy:</strong><br>
        <span>Síla: {{item.strengthBonus}}</span><br>
        <span>Obratnost: {{item.agilityBonus}}</span><br>
        <span>Inteligence: {{item.intelligenceBonus}}</span><br>
        <span>Body zbroje: {{item.armorPoints}}</span><br>
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
  String newTodo = '';

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
