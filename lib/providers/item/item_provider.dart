import 'package:flutter/material.dart';

import '../../database/item_api/item_api.dart';
import '../../models/item/item.dart';

class ItemProvider extends ChangeNotifier {
  ItemProvider() {
    load();
  }
  Item? item(String codeValue) {
    final int index =
        _items.indexWhere((Item element) => element.code == codeValue);
    return index < 0 ? null : _items[index];
  }

  List<Item> _items = <Item>[];
  List<Item> get items => _items;
  load() async {
    _items = await ItemAPI().get();
    notifyListeners();
  }

  Item get _null => Item(
        id: 'null',
        name: 'null',
        code: 'null',
        line: 'null',
        category: 'null',
        subCategory: 'null',
        formula: 'null',
        manufacturer: 'null',
        supplier: 'null',
        averagePrice: 0,
        discount: 0,
        quantity: 0,
        salePrice: 0,
      );
}
