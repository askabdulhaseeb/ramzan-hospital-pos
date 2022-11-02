import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_category.dart';
import '../../../models/item/item_formula.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../providers/item/item_formula_provider.dart';
import '../../../utilities/utilities.dart';

class ItemFormulaDropdown extends StatelessWidget {
  const ItemFormulaDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Formula',
            style: Utlities.itemTitleTextStyle,
          ),
        ),
        Expanded(
          child: Consumer<ItemFormulaProvider>(builder:
              (BuildContext context, ItemFormulaProvider formulaPro, _) {
            final List<ItemFormula> formulas = formulaPro.formulas;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
              child: DropdownFormField<ItemFormula>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: 'Formula',
                ),
                onChanged: (dynamic str) => formulaPro.onFormulaUpdate(str),
                validator: (dynamic str) {
                  if (formulaPro.selectedFormula == null) {
                    return 'Select Category';
                  }
                  return null;
                },
                displayItemFn: (dynamic value) => Text(
                  value?.formula ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                findFn: (dynamic str) async => formulas,
                filterFn: (dynamic value, String str) =>
                    value.formula.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                dropdownItemFn: (dynamic value, int position, bool focused,
                        dynamic lastSelectedItem, dynamic onTap) =>
                    ListTile(
                  title: Text(value.formula),
                  onTap: onTap,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
