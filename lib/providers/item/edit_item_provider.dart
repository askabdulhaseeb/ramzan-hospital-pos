import 'package:flutter/cupertino.dart';

import '../../database/item_api/item_api.dart';
import '../../models/item/item.dart';
import 'item_provider.dart';

class EditItemProvider extends ChangeNotifier {
  EditItemProvider() {}
  update(ItemProvider itemPro) {
    _items = itemPro.items;
    print(_items.length);
    notifyListeners();
  }

  Item? item(String codeValue) {
    final int index =
        _items.indexWhere((Item element) => element.code == codeValue);
    if (index >= 0) {
      _editItem = _items[index];
    }
    return index < 0 ? null : _items[index];
  }

  List<Item> _items = <Item>[];

  Item _editItem = Item(
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
  Item get editItem => _editItem;
  Item _null() => Item(
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
