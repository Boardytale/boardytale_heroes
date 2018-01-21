import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'new-item',
templateUrl: 'new_item_component.html',
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


  NewItemComponent(this.itemsService) {
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
    _onNewItem.add(null);
    itemsService.createItem(newItem);
    itemsService.editingItem = null;
  }

  void cancel() {
    _onNewItem.add(null);
    itemsService.editingItem = null;
  }
}
