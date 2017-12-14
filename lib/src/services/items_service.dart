import 'dart:async';
import 'dart:convert';

import 'package:angular/core.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/src/firestore.dart';
import 'package:firebase/src/assets/assets.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class ItemsService {
  Future<DocumentReference> createItem(Item item) async {
    return firestore().collection('items').add(item.toMap());

//    firestore().collection('items').onSnapshot.listen((QuerySnapshot snapshot) {
//      print(snapshot);
//      snapshot.forEach((DocumentSnapshot value) {
//        print(JSON.encode(value.data()));
//      });
//    });
//    return await null;
  }
}
