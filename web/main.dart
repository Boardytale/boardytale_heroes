import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:boardytale_heroes/root_component.dart';
import 'package:firebase/src/top_level.dart';

void main() {
  initializeApp(
    apiKey: "AIzaSyAbS5NovJ7w3KQElK8KcQV-8w2Ypy4NiIs",
    authDomain: "boardytale-heroes.firebaseapp.com",
    databaseURL: "https://boardytale-heroes.firebaseio.com",
    storageBucket: "boardytale-heroes.appspot.com",
    projectId: "boardytale-heroes",
  );
  bootstrap(RootComponent, [
    ROUTER_PROVIDERS,
    // Remove next line in production
    provide(LocationStrategy, useClass: HashLocationStrategy),
  ]);
}
