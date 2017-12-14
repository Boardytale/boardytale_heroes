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
     
  Název: <input label="Název" autoFocus style="width:80%" [(ngModel)]="newItem.name"><br>
  Hmotnost: <input type="number" [(ngModel)]="weight" step="1"><br>
  
  <button (click)="createItem()">Vytvořit</button>
  ''',
//  <material-input label="Hmotnost" autoFocus floatingLabel style="width:80%"[(ngModel)]="weight"></material-input>
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives
  ],
  providers: const [ItemsService],
)
class NewItemComponent implements OnInit {
  Item newItem = new Item();
  final ItemsService itemsService;

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
    itemsService.createItem(newItem);
  }
}
