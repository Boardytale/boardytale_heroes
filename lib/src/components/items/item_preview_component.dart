import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/model/model.dart';
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
        <span *ngIf="item.type == 'weapon'">Profil síly: {{item.strengthPoints}}</span><br>
        <span *ngIf="item.type == 'weapon'">Profil obratnosti: {{item.agilityPoints}}</span><br>
        <span *ngIf="item.type == 'weapon'">Profil inteligence: {{item.intelligencePoints}}</span><br>
        <span *ngIf="item.type == 'weapon'">Maska útoku: {{item.mask}}</span><br>
        <button (click)="delete()">Vymaž</button>
      
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
  providers: const [ItemsService],
)
class ItemPreviewComponent implements OnInit {
  final ItemsService itemsService;

  List<Item> items = [];
  String newTodo = '';

  ItemPreviewComponent(this.itemsService);

  @Input("item")
  Item item;

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }

  void delete() {
    itemsService.delete(item);
  }
}
