import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/components/shared/buttoned_number_input_component.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';

@Component(
  selector: 'nav-component',
  templateUrl: 'nav_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
    ButtonedNumberInputComponent
  ],
  providers: const [
    materialProviders,
    AuthService,
  ],
)
class NavComponent {
  AuthService authService;

  NavComponent(this.authService);

  void login() {
    authService.login();
  }
}
