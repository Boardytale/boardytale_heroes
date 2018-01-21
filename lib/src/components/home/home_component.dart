import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/nav/nav_component.dart';

@Component(
  selector: 'home-component',
  templateUrl: 'home_component.html',
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
class HomeComponent {}
