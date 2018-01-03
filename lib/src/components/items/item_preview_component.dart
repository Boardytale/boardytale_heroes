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
        <span>Hmotnost: {{item.weight}}</span>
      
      </div>
      <div class="item-preview__bonuses">
      <strong>Bonusy:</strong><br>
        <span>Síla: {{item.strengthBonus}}</span><br>
        <span>Obratnost: {{item.agilityBonus}}</span><br>
        <span>Inteligence: {{item.intelligenceBonus}}</span><br>
        <span>Body zbroje: {{item.armorPoints}}</span><br>
        <span>Bonusová mana: {{item.manaBonus}}</span>
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
  final ItemsService todoListService;

  List<Item> items = [];
  String newTodo = '';

  ItemPreviewComponent(this.todoListService);

  @Input("item")
  Item item;

  @override
  Future<Null> ngOnInit() async {
//    items = await todoListService.getTodoList();
  }
}
