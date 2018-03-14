import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/firestore.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class ShopsService {
  Item editingItem;
  Shop selected;
  ItemsService itemsService;
  ShopsService(this.itemsService);

  Future<DocumentReference> createShop(Shop shop) async {
    if(shop.id != null) {
      return firestore().collection('shops').doc(shop.id).update(data: shop.toMap());
    }else{
      return firestore().collection('shops').add(shop.toMap());
    }
  }

  Stream<List<Shop>> getShops() {
    return firestore()
        .collection('shops')
        .onSnapshot
        .map((QuerySnapshot snapshot) {
      List<Shop> out = [];
      snapshot.forEach((DocumentSnapshot value) {
        Map data = value.data();
        data["id"] = value.id;
        out.add(new Shop()..fromMap(data, itemsService));
      });
      return out;
    });
  }

  void delete(Shop shop) {
    firestore().collection('shops').doc(shop.id).delete();
  }

  Future<Shop> getShopById(String itemId) async {
    return firestore()
        .collection('shops')
        .doc(itemId)
        .get()
        .asStream()
        .map((DocumentSnapshot document) {
      Map data = document.data();
      data["id"] = document.id;
      return new Shop()..fromMap(data, itemsService);
    }).first;
  }

  void saveSelected() {
    createShop(selected);
  }
}
