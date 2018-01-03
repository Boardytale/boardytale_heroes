import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:boardytale_heroes/src/components/items/items_component.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:firebase/firebase.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    ItemsComponent
  ],
  providers: const [materialProviders, ItemsService],
)
class AppComponent implements OnInit {

  @override
  ngOnInit() {
    initializeApp(
        apiKey: "AIzaSyAbS5NovJ7w3KQElK8KcQV-8w2Ypy4NiIs",
        authDomain: "boardytale-heroes.firebaseapp.com",
        databaseURL: "https://boardytale-heroes.firebaseio.com",
        storageBucket: "boardytale-heroes.appspot.com",
        projectId: "boardytale-heroes",

//        messagingSenderId: "499749973436",
    );
  }
}