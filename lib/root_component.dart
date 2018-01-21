import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:boardytale_heroes/src/components/admin/admin_component.dart';
import 'package:boardytale_heroes/src/components/app/app_component.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['root_component.css'],
  templateUrl: 'root_component.html',
  directives: const [
    materialDirectives,
    COMMON_DIRECTIVES,
    CORE_DIRECTIVES,
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
//  const Redirect(path: '/', redirectTo: const ['App']),
  const Redirect(path: '/', redirectTo: const ['Admin']),
  const Route(path: '/app/...', name: 'App', component: AppComponent),
  const Route(path: '/admin/...', name: 'Admin', component: AdminComponent),
])
class RootComponent {}
