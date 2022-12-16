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
String? itemName(String Value) {

    final int index =
        _items.indexWhere((Item element) => element.id == Value);
    return index < 0 ? null : _items[index].name;
  }
  load() async {
    _items = await ItemAPI().get();
    notifyListeners();
  }

  onSearch(String? value) {
    _search = value;
    notifyListeners();
  }

  List<Item> itemSearch() {
    final List<Item> temp = <Item>[];
    for (Item element in _items) {
      String el = '';
      if (selectSearch == 'Code') {
        el = element.code;
      } else if (selectSearch == 'Price') {
        el = element.salePrice.toString();
      } else {
        el = element.name;
      }
      if (_search == null || (_search?.isEmpty ?? true)) {
        temp.add(element);
      } else if (el.toLowerCase().startsWith((_search?.toLowerCase() ?? ''))) {
        temp.add(element);
      }
    }
    return temp;
  }

  updateSelectSearch(String value) {
    selectSearch = value;
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
  List<String> searchingItems = <String>['Name', 'Code', 'Price'];
  String selectSearch = 'Name';

  List<Item> _items = <Item>[];
  List<Item> get items => _items;
  String? _search;
}
