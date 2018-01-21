import 'dart:async';
import 'package:angular/src/core/metadata.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'attack-input',
  template: '''
  buttoned
  <div>
    <button (click)="increase(0)">+</button>
    <button (click)="increase(1)">+</button>
    <button (click)="increase(2)">+</button>
    <button (click)="increase(3)">+</button>
    <button (click)="increase(4)">+</button>
    <button (click)="increase(5)">+</button><br>
    <button (click)="decrease(0)">-</button>
    <button (click)="decrease(1)">-</button>
    <button (click)="decrease(2)">-</button>
    <button (click)="decrease(3)">-</button>
    <button (click)="decrease(4)">-</button>
    <button (click)="decrease(5)">-</button><br>
  </div>
  {{value}}
  ''',
  directives: const [
    CORE_DIRECTIVES,
    formDirectives
  ]
)
class AttackInputComponent {
  List<int> _value = [0,0,0,0,0,0];

  List<int> get value => _value;

  @Input("value")
  void set value(List<int> val) {
    _value = val;
  }

  final _valueChange = new StreamController<List<int>>();
  @Output()
  Stream<List<int>> get valueChange => _valueChange.stream;

  @Input("decimal")
  bool decimal = false;

  void increase(int order) {
    _value[order]++;
    _valueChange.add(_value);
  }

  void decrease(int order) {
    _value[order]--;
    _valueChange.add(_value);
  }

}
