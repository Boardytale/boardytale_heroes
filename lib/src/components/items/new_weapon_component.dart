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
  templateUrl: 'new_weapon_component.html',
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
