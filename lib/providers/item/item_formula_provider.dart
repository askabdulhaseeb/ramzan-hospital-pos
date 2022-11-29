import 'package:flutter/material.dart';
import '../../database/item_api/formula_api.dart';
import '../../models/item/item_formula.dart';

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
}
