import 'package:angular/src/core/metadata.dart';

import 'package:angular/src/common/directives/core_directives.dart';

import 'package:angular_components/angular_components.dart';

import 'package:angular_components/material_input/material_number_accessor.dart';

import 'package:angular_forms/src/directives.dart';

import 'package:boardytale_heroes/src/components/shared/attack_component.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

import 'package:angular/src/core/metadata/lifecycle_hooks.dart';

import 'package:boardytale_heroes/src/model/model.dart';

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'new-weapon',
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
  Doporučená cena: <input type="number" [(ngModel)]="newItem.suggestedPrice" step="1"><br>
    
    <span>
      Body přesnosti: <input type="number" [(ngModel)]="newItem.precision" step="1"><br>
    </span>
    
    <span>
      Efektivní inteligence: <input type="number" [(ngModel)]="newItem.effectiveIntelligence" step="1"><br>
    </span>
    <span>
      Efektivní síla: <input type="number" [(ngModel)]="newItem.effectiveStrength" step="1"><br>
    </span>
    <span>
      Efektivní obratnost: <input type="number" [(ngModel)]="newItem.effectiveAgility" step="1"><br>
    </span>
    <span>
      Základní útok: <br><attack-input [(value)]="newItem.baseAttack"></attack-input><br>
    </span>
  
  <button (click)="createItem()">{{newItem.id == "noid"?"Vytvořit": "Upravit"}}</button>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
    AttackInputComponent,
  ],
)
class NewWeaponComponent implements OnInit {
  Weapon newItem = new Weapon();
  final ItemsService itemsService;

  final _onNewItem = new StreamController<Null>();

  @Output("onNewItem")
  get onNewItem => _onNewItem.stream;

  NewWeaponComponent(this.itemsService){
    if(itemsService.editingItem != null){
      newItem = itemsService.editingItem;
    }
  }

  get weight => newItem.weight.toDouble();

  set weight(double value) {
    newItem.weight = value.floor();
  }

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }

  void createItem() {
    newItem.type=Weapon.typeName;
    _onNewItem.add(null);
    itemsService.createItem(newItem);
    itemsService.editingItem = null;
  }

  void cancel() {
    _onNewItem.add(null);
    itemsService.editingItem = null;
  }
}
