import 'package:flutter/material.dart';
import '../../models/item/item_formula.dart';

class ItemFormulaProvider extends ChangeNotifier {
  ItemFormulaProvider() {
    _formulas = <ItemFormula>[
      ItemFormula(id: '1', formula: 'formula1'),
      ItemFormula(id: '2', formula: 'formula2'),
      ItemFormula(id: '3', formula: 'formula3'),
      ItemFormula(id: '4', formula: 'formula4'),
      ItemFormula(id: '5', formula: 'formula5'),
      ItemFormula(id: '6', formula: 'formula6'),
    ];
  }
  List<ItemFormula> _formulas = <ItemFormula>[];
  ItemFormula? _selectedFormula;

  List<ItemFormula> get formulas => <ItemFormula>[..._formulas];
  ItemFormula? get selectedFormula => _selectedFormula;

  void onFormulaUpdate(ItemFormula? value) {
    _selectedFormula = value;
    notifyListeners();
  }
}
