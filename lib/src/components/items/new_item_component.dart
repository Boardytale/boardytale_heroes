import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'new-item',
  template: '''
  
     <h1>Vytvořit předmět</h1>
     <button (click)="cancel()">Zrušit</button><br>
  Název: <input label="Název" autoFocus style="width:80%" [(ngModel)]="newItem.name"><br>
  Hmotnost: <input type="number" [(ngModel)]="weight" step="1"><br>
  Body zbroje: <input type="number" [(ngModel)]="newItem.armorPoints" step="1"><br>
  Bonus životů: <input type="number" [(ngModel)]="newItem.healthBonus" step="1"><br>
  Bonus many: <input type="number" [(ngModel)]="newItem.manaBonus" step="1"><br>
  Bonus síly: <input type="number" [(ngModel)]="newItem.strengthBonus" step="1"><br>
  Bonus obratnosti: <input type="number" [(ngModel)]="newItem.agilityBonus" step="1"><br>
  Bonus inteligence: <input type="number" [(ngModel)]="newItem.intelligenceBonus" step="1"><br>
  Bonus spirituality: <input type="number" [(ngModel)]="newItem.spiritualityBonus" step="1"><br>
  Bonus přestnosti: <input type="number" [(ngModel)]="newItem.precisionBonus" step="1"><br>
  Bonus energie: <input type="number" [(ngModel)]="newItem.energyBonus" step="1"><br>
  
  Typ předmětu:
    <select #itemType>
      <option value="weapon">Zbraň</option>
    </select>
  
  <button (click)="createItem()">Vytvořit</button>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives
  ],
)
class NewItemComponent implements OnInit {
  Item newItem = new Item();
  final ItemsService itemsService;

  StreamController<Null> _onNewItem = new StreamController<Null>();

  @Output("onNewItem")
  get onNewItem => _onNewItem.stream;


  NewItemComponent(this.itemsService);

  get weight => newItem.weight.toDouble();

  set weight(double value) {
    newItem.weight = value.floor();
  }

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }

  void createItem() {
    _onNewItem.add(null);
    itemsService.createItem(newItem);
  }

  void cancel() {
    _onNewItem.add(null);
    itemsService.editingItem = null;
  }
}
