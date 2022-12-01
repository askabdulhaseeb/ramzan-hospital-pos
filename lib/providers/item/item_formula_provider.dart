import 'package:flutter/material.dart';
import '../../database/item_api/formula_api.dart';
import '../../models/item/item_formula.dart';
import 'edit_item_provider.dart';

class ItemFormulaProvider extends ChangeNotifier {
  ItemFormulaProvider() {
    loadData();
  }
  loadData() async {
    _formulas = await FormulaAPI().get();
    notifyListeners();
  }

  List<ItemFormula> _formulas = <ItemFormula>[];
  ItemFormula? _selectedFormula;

  List<ItemFormula> get formulas => <ItemFormula>[..._formulas];
  ItemFormula? get selectedFormula => _selectedFormula;

  void onFormulaUpdate(ItemFormula? value) {
    _selectedFormula = value;
    notifyListeners();
  }
  void formulaUpdate(ItemFormula value) {
    _formulas.add(value);
    notifyListeners();
  }

  updatevalue(EditItemProvider editPro) {


    if (editPro.editItem.formula == 'null') {
    } else {
      for (int i = 0; i < _formulas.length; i++) {
        if (_formulas[i].id == editPro.editItem.formula) {
          
          _selectedFormula = _formulas[i];
          edit = true;
          
          break;
        }
      }
     
    }
    notifyListeners();
  }
   bool edit = false;
}
