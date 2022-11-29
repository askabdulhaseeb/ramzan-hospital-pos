import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/supplier_api.dart';
import '../../../function/time_date_function.dart';
import '../../../models/item/item_supplier.dart';
import '../../../providers/item/item_supplier_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_textformfield.dart';

class ItemSupplierDropdown extends StatefulWidget {
  const ItemSupplierDropdown({super.key});

  @override
  State<ItemSupplierDropdown> createState() => _ItemSupplierDropdownState();
}

class _ItemSupplierDropdownState extends State<ItemSupplierDropdown> {
  TextEditingController _supplier = TextEditingController();
  uploadData(BuildContext context) async {
    ItemSupplierProvider supplierPro =
        Provider.of<ItemSupplierProvider>(context, listen: false);
    ItemSupplier value =
        ItemSupplier(id: TimeStamp.timestamp.toString(), name: _supplier.text);
    bool temp = await SupplierAPI().add(value);
    supplierPro.suplierUpdate(value);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'ok');
      _supplier.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Supplier',
            style: Utlities.itemTitleTextStyle,
          ),
        ),
        Expanded(
          child: Consumer<ItemSupplierProvider>(builder:
              (BuildContext context, ItemSupplierProvider supplierPro, _) {
            final List<ItemSupplier> supp = supplierPro.suppliers;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
              child: DropdownFormField<ItemSupplier>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: 'Supplier',
                ),
                onChanged: (dynamic str) => supplierPro.onSupplierUpdate(str),
                validator: (dynamic str) {
                  if (supplierPro.selectedSupplier == null) {
                    return 'Select Supplier';
                  }
                  return null;
                },
                displayItemFn: (dynamic value) => Text(
                  value?.name ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                findFn: (dynamic str) async => supp,
                filterFn: (dynamic value, String str) =>
                    value.name.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                dropdownItemFn: (dynamic value, int position, bool focused,
                        dynamic lastSelectedItem, dynamic onTap) =>
                    ListTile(
                  title: Text(value.name),
                  onTap: onTap,
                ),
              ),
            );
          }),
        ),
        IconButton(
            onPressed: () {
              print('icon button pressed');
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add Supplier'),
                  content: CustomTextFormField(
                    controller: _supplier,
                    hint: 'Supplier ',
                    validator: (value) => CustomValidator.lessThen2(value),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        uploadData(context);
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
