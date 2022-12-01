import 'package:flutter/material.dart';
import '../../database/item_api/supplier_api.dart';
import '../../models/item/item_supplier.dart';
import 'edit_item_provider.dart';

class ItemSupplierProvider extends ChangeNotifier {
  ItemSupplierProvider() {
    loadData();
  }
  loadData() async {
    _suppliers = await SupplierAPI().get();
    notifyListeners();
  }

  List<ItemSupplier> _suppliers = <ItemSupplier>[];
  ItemSupplier? _selectedSupplier;

  List<ItemSupplier> get suppliers => <ItemSupplier>[..._suppliers];
  ItemSupplier? get selectedSupplier => _selectedSupplier;

  void onSupplierUpdate(ItemSupplier? value) {
    _selectedSupplier = value;
    notifyListeners();
  }

  void suplierUpdate(ItemSupplier value) {
    _suppliers.add(value);
    notifyListeners();
  }

  updatevalue(EditItemProvider editPro) {
    if (editPro.editItem.supplier == 'null') {
    } else {
      for (int i = 0; i < _suppliers.length; i++) {
        if (_suppliers[i].id == editPro.editItem.formula) {
          _selectedSupplier = _suppliers[i];
          edit = true;

          break;
        }
      }
    }
    notifyListeners();
  }

  bool edit = false;
}
