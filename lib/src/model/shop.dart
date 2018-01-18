part of boardytale.heroes.model;

class Shop {
  String id;
  String name;
  String description;
  Map<Item, int> items = {};

  void fromMap(Map data, ItemsService itemsService) {
    id = data["id"];
    name = data["name"];
    description = data["description"];
    Map<String, int> itemsData = data["items"];
    itemsData.forEach((itemId, quantity) {
      itemsService.getItemById(itemId).then((Item itemData) {
        items.putIfAbsent(itemData, () => quantity);
      });
    });
  }

  Map toMap() {
    Map out = {};
    out["id"] = id;
    out["description"] = description;
    out["name"] = name;
    Map outItems = {};

    items.forEach((Item item, int quantity) {
      outItems.putIfAbsent(item.id, () => quantity);
    });
    out["items"] = outItems;
    return out;
  }
}
