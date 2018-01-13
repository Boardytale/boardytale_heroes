part of boardytale.heroes.model;

class User {
  String uid = "";
  String displayName = "";
  String email = "";
  bool logged = false;

  void fromFirebaseUser(firebase.User user) {
    uid = user.uid;
    displayName = user.displayName;
    email = user.email;
  }

  void fromMap(Map data) {
    uid = data["uid"];
    displayName = data["displayName"];
    email = data["email"];
    fromUserDataMap(data);
  }

  void fromUserDataMap(Map data) {
//    solvedIssues = data["solvedIssues"];
  }

  Map toMap() {
    Map out = {};
    out["uid"] = uid;
    out["displayName"] = displayName;
    out["email"] = email;
    return out;
  }
}
