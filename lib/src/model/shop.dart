part of boardytale.heroes.model;

class Shop {
  String id;
  String name;
  String description;
  List<ShopItem> items = [];

  void fromMap(Map data, ItemsService itemsService) {
    id = data["id"];
    name = data["name"];
    description = data["description"];
    List<Map> itemsData = data["items"];
    itemsData.forEach((itemData) {
      ShopItem newItem = new ShopItem()..fromMap(itemData);
      itemsService.getItemById(newItem.itemId).then((Item originalItem) {
        if(originalItem != null) {
          items.add(newItem..item = originalItem);
        }
      });
    });
  }

  Map toMap() {
    Map out = {};
    out["id"] = id;
    out["description"] = description;
    out["name"] = name;
    out["items"] = items.map((ShopItem item)=>item.toMap());
    return out;
  }
}

class ShopItem extends Items {
  num price = 10;

  Map toMap() {
    Map out = {};
    out["price"] = price.toInt();
    return out;
  }

  void fromMap(Map data) {
    price = data["price"];
  }
}
