import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:boardytale_heroes/src/components/admin/admin_component.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
    BS_DIRECTIVES,
    ROUTER_DIRECTIVES,
  ],
  providers: const [
    materialProviders,
    ItemsService,
    AuthService,
    HeroesService,
    ShopsService,
  ],
)
@RouteConfig(const [
//  const Route(path: '/', name: 'Home', component: HomeComponent),
  const Redirect(path: '/', redirectTo: const ['Admin']),
  const Route(path: '/admin', name: 'Admin', component: AdminComponent),
])
class AppComponent {}
