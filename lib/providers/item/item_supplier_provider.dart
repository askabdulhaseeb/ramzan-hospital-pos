import 'package:flutter/material.dart';
import '../../models/item/item_supplier.dart';

class ItemSupplierProvider extends ChangeNotifier {
  ItemSupplierProvider() {
    _suppliers = <ItemSupplier>[
      ItemSupplier(id: '1', name: 'Supplier1'),
      ItemSupplier(id: '2', name: 'Supplier2'),
      ItemSupplier(id: '3', name: 'Supplier3'),
      ItemSupplier(id: '4', name: 'Supplier4'),
      ItemSupplier(id: '5', name: 'Supplier5'),
      ItemSupplier(id: '6', name: 'Supplier6'),
    ];
  }
  List<ItemSupplier> _suppliers = <ItemSupplier>[];
  ItemSupplier? _selectedSupplier;

  List<ItemSupplier> get suppliers => <ItemSupplier>[..._suppliers];
  ItemSupplier? get selectedSupplier => _selectedSupplier;

  void onSupplierUpdate(ItemSupplier? value) {
    _selectedSupplier = value;
    notifyListeners();
  }
}
