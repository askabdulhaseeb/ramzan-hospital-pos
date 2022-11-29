import 'package:flutter/material.dart';
import '../../database/item_api/manufacturer_api.dart';
import '../../models/item/item_manufacturer.dart';

class ItemManufacturerProvider extends ChangeNotifier {
  ItemManufacturerProvider() {
    loadData();
  }

  loadData() async {
    _manufacturer = await ManufacturerAPI().get();
    notifyListeners();
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
  void manufacturerUpdate(ItemManufacturer value) {
    _manufacturer.add(value);
    notifyListeners();
  }
}
