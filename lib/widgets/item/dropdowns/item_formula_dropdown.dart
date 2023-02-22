import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/formula_api.dart';
import '../../../function/time_date_function.dart';
import '../../../models/item/item_category.dart';
import '../../../models/item/item_formula.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../providers/item/item_formula_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_textformfield.dart';

class ItemFormulaDropdown extends StatefulWidget {
  const ItemFormulaDropdown({super.key});

  @override
  State<ItemFormulaDropdown> createState() => _ItemFormulaDropdownState();
}

class _ItemFormulaDropdownState extends State<ItemFormulaDropdown> {
  final TextEditingController _formula = TextEditingController();
  uploadformula(BuildContext context) async {
    ItemFormulaProvider formulaPro =
        Provider.of<ItemFormulaProvider>(context, listen: false);
    ItemFormula value =
        ItemFormula(id: TimeStamp.timestamp.toString(), formula: _formula.text);
    bool temp = await FormulaAPI().add(value);
    formulaPro.formulaUpdate(value);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'ok');
      _formula.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemFormulaProvider formulaPro = Provider.of<ItemFormulaProvider>(context);
    final List<ItemFormula> formulas = formulaPro.formulas;
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
          child:  Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
                  child: DropdownButtonFormField<ItemFormula>(
                     isExpanded: true,
                       decoration: InputDecoration(
                border:const OutlineInputBorder(),
                //suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText:  (formulaPro.edit) ? formulaPro.selectedFormula==null?'Formula' :formulaPro.selectedFormula!.formula : 'Formula',
                ),
                alignment: Alignment.centerLeft,
                //value: formulaPro.selectedFormula,
                style: const TextStyle(color: Colors.black),
                //underline: const SizedBox(),
                hint: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                items: formulaPro.formulas
                    .map((ItemFormula cats) => DropdownMenuItem<ItemFormula>(
                          value: cats,
                          child: Text(
                           // overflow: TextOverflow.ellipsis,
                            cats.formula.toUpperCase(),
                            style: const TextStyle(),
                          ),
                        ))
                    .toList(),
                onChanged: (ItemFormula? value) =>
                    formulaPro.onFormulaUpdate(value),
              ),
            
            ),
        ),
       formulaPro.edit
            ? const SizedBox()
            : IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add Formula'),
                  content: CustomTextFormField(
                    controller: _formula,
                    hint: 'formula ',
                    validator: (value) => CustomValidator.lessThen2(value),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        uploadformula(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            splashRadius: 16,
            icon: const Icon(
              Icons.add_box_rounded,
            )),
      ],
    );
  }
}
