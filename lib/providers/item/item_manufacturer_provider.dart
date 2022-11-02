import 'package:flutter/material.dart';
import '../../models/item/item_manufacturer.dart';

class ItemManufacturerProvider extends ChangeNotifier {
  ItemManufacturerProvider() {
    _manufacturer = <ItemManufacturer>[
      ItemManufacturer(id: '1', name: 'name1'),
      ItemManufacturer(id: '2', name: 'name2'),
      ItemManufacturer(id: '3', name: 'name3'),
      ItemManufacturer(id: '4', name: 'name4'),
      ItemManufacturer(id: '5', name: 'name5'),
      ItemManufacturer(id: '6', name: 'name6'),
    ];
  }
  List<ItemManufacturer> _manufacturer = <ItemManufacturer>[];
  ItemManufacturer? _selectedManufacturer;

  List<ItemManufacturer> get manufacturer =>
      <ItemManufacturer>[..._manufacturer];
  ItemManufacturer? get selectedManufacturer => _selectedManufacturer;

  void onManufacturerUpdate(ItemManufacturer? value) {
    _selectedManufacturer = value;
    notifyListeners();
  }
}
