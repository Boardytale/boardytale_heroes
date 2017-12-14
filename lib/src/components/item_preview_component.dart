import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';

@Component(
  selector: 'item-preview',
  template: '''
  
      item preview
  
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [ItemsService],
)
class ItemPreviewComponent implements OnInit {
  final ItemsService todoListService;

  List<Item> items = [];
  String newTodo = '';

  ItemPreviewComponent(this.todoListService);

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }
}
