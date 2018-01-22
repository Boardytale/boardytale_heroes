import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:boardytale_heroes/src/components/app/game/game_component.dart';
import 'package:boardytale_heroes/src/components/app/hero/hero_component.dart';
import 'package:boardytale_heroes/src/components/app/nav/nav_component.dart';
import 'package:boardytale_heroes/src/components/app/pub/pub_component.dart';
import 'package:boardytale_heroes/src/components/app/shop/shop_component.dart';
import 'package:boardytale_heroes/src/components/app/workshop/workshop_component.dart';

@Component(
  selector: 'app-component',
  templateUrl: 'app_component.html',
  directives: const [
    CORE_DIRECTIVES,
    NavComponent,
    materialDirectives,
    materialNumberInputDirectives,
    ROUTER_DIRECTIVES,
  ],
)
@RouteConfig(const [
  const Route(path: '/game', name: 'Game', component: GameComponent, useAsDefault: true),
  const Route(path: '/shop', name: 'Shop', component: ShopComponent),
  const Route(path: '/workshop', name: 'Workshop', component: WorkshopComponent),
  const Route(path: '/pub', name: 'Pub', component: PubComponent),
  const Route(path: '/hero', name: 'Hero', component: HeroComponent),
])
class AppComponent {}
