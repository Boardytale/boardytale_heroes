import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/app/nav/nav_component.dart';

@Component(
  selector: 'shop-component',
  templateUrl: 'shop_component.html',
  directives: const [
    CORE_DIRECTIVES,
    NavComponent,
    materialDirectives,
    materialNumberInputDirectives,
  ],
  providers: const [
    materialProviders,
  ],
)
class ShopComponent {}
