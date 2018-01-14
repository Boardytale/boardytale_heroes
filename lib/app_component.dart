import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/heroes/heroes_component.dart';
import 'package:boardytale_heroes/src/components/items/items_component.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:firebase/firebase.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    ItemsComponent,
    HeroesComponent,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES
  ],
  providers: const [
    materialProviders,
    ItemsService,
    AuthService,
    HeroesService,
  ],
)
class AppComponent implements OnInit {
  AuthService authService;

  AppComponent(this.authService);

  @override
  ngOnInit() {

  }

  void login(){
    authService.login();
  }
}