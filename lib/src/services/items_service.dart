import 'dart:async';
import 'package:angular/core.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/firestore.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class ItemsService {
  Future<DocumentReference> createItem(Item item) async {
    return firestore().collection('items').add(item.toMap());
  }

  Future<Stream<List<Item>>> getItems() async {
    return firestore().collection('items').onSnapshot.map((QuerySnapshot snapshot) {
      List<Item> out = [];
      snapshot.forEach((DocumentSnapshot value) {
        out.add(new Item()..fromMap(value.data()));
      });
      return out;
    });
  }
}
