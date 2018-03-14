import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/shops_service.dart';

@Component(
  selector: 'edit-shop',
  templateUrl: 'shop_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
  ],
)
class ShopsComponent implements OnInit {
  final ShopsService shopsService;
  final HeroesService heroesService;
  final AuthService authService;
  bool shoppingMode = true;
  List<Shop> shops = [];
  bool itemsVisible = true;

  ShopsComponent(
    this.authService,
    this.shopsService,
    this.heroesService,
  );

  @override
  Future<Null> ngOnInit() async {
    Stream<List<Shop>> shopsData = await this.shopsService.getShops();
    shopsData.listen((List<Shop> shops) {
      this.shops = shops;
    });
//    authService.onUserData.stream.listen((_) async {
//    });
  }

  void selectShop(Shop shop) {
    shopsService.selected = shop;
  }

  void createShop() {
    shopsService.createShop(shopsService.selected);
  }

  void removeItem(ShopItem item) {
    shopsService.selected.items.remove(item);
    shopsService.saveSelected();
  }

  void increaseQuantity(ShopItem item, int increaseQuantity) {
    item.quantity += increaseQuantity;
    shopsService.saveSelected();
  }

  void resetQuantity(ShopItem item) {
    item.quantity = 0;
  }

  void priceChanged() {
    shopsService.saveSelected();
  }

  void buy(ShopItem item) {
    if (heroesService.selected.money > item.price && item.quantity > 0) {
      heroesService.selected.money -= item.price;
      heroesService.selected.items.add(item.item);
      heroesService.saveSelected();
      item.quantity--;
      shopsService.saveSelected();
    }
  }
}
