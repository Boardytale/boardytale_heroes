import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/firestore.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class ItemsService {
  Item editingItem;

  Future<DocumentReference> createItem(Item item) async {
    if (item.id != "noid") {
      return firestore()
          .collection('items')
          .doc(item.id)
          .update(data: item.toMap());
    } else {
      return firestore().collection('items').add(item.toMap());
    }
  }

  Future<Stream<List<Item>>> getItems() async {
    return firestore()
        .collection('items')
        .onSnapshot
        .map((QuerySnapshot snapshot) {
      List<Item> out = [];
      snapshot.forEach((DocumentSnapshot value) {
        Map data = value.data();
        data["id"] = value.id;
        out.add(_getItemByData(data));
      });
      return out;
    });
  }

  void delete(Item item) {
    firestore().collection('items').doc(item.id).delete();
  }

  Future<Item> getItemById(String itemId) async {
    return firestore()
        .collection('items')
        .doc(itemId)
        .get()
        .asStream()
        .map((DocumentSnapshot document) {
      if (document.exists) {
        Map data = document.data();
        data["id"] = document.id;
        return _getItemByData(data);
      } else {
        print("item not found $itemId");
        return null;
      }
    }).first;
  }

  Item _getItemByData(Map data) {
    if (!Item.itemTypes.contains(data["type"])) {
      data["type"] = Weapon.typeName;
    }
    if (data["type"] == Weapon.typeName) {
      return new Weapon()..fromMap(data);
    } else {
      return new Item()..fromMap(data);
    }
  }
}
