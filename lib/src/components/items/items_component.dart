import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/items/item_preview_component.dart';
import 'package:boardytale_heroes/src/components/items/new_item_component.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'items',
  template: '''
     items component
      <new-item></new-item>
      <item-preview *ngFor="let item of items" [item]="item"></item-preview>
  
  ''',
  directives: const [CORE_DIRECTIVES, materialDirectives, NewItemComponent, ItemPreviewComponent],
)
class ItemsComponent implements OnInit {
  final ItemsService itemsService;

  List<Item> items = [];
  String newTodo = '';

  ItemsComponent(this.itemsService);

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Item>> itemsData = await this.itemsService.getItems();
    itemsData.listen((List<Item> items) {
      this.items = items;
    });
//    items = await todoListService.getTodoList();
  }
}
