import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/auth_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/firestore.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class HeroesService {
  AuthService authService;
  ItemsService itemsService;
  Hero selected;

  HeroesService(this.authService, this.itemsService) {}

  Future<DocumentReference> createOrEditHero(Hero hero) async {
    hero.userId = authService.user.uid;
    if (hero.id == "noid") {
      return firestore().collection('heroes').add(hero.toMap());
    } else {
      return firestore().collection('heroes').doc(hero.id).update(data: hero.toMap());
    }
  }

  Future<Stream<List<Hero>>> getHeroes() async {
    return firestore()
        .collection('heroes')
        .where("userId", "==", authService.user.uid)
        .onSnapshot
        .map((QuerySnapshot snapshot) {
      List<Hero> out = [];
      snapshot.forEach((DocumentSnapshot value) {
        out.add(new Hero()
          ..fromMap(value.data(), itemsService)
          ..id = value.id);
      });
      return out;
    });
  }

  void delete(Item item) {
    firestore().collection('items').doc(item.id).delete();
  }

  void saveSelected() {
    createOrEditHero(selected);
  }
}
