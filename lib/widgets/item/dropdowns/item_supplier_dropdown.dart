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
    ItemSupplierProvider supplierPro = Provider.of<ItemSupplierProvider>(context);
    final List<ItemSupplier> supp = supplierPro.suppliers;
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
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
                  child: DropdownButtonFormField<ItemSupplier>(
                  isExpanded: true,
                       decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
                alignment: Alignment.centerLeft,
               // value: manuPro.selectedManufacturer,
                style: const TextStyle(color: Colors.black),
                //underline: const SizedBox(),
                hint: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                items: supplierPro.suppliers
                    .map((ItemSupplier suppliers) => DropdownMenuItem<ItemSupplier>(
                          value: suppliers,
                          child: Text(
                            suppliers.name.toUpperCase(),
                            style: const TextStyle(),
                          ),
                        ))
                    .toList(),
                onChanged: (ItemSupplier? value) =>
                   supplierPro.onSupplierUpdate(value!),
              ),
              // child: DropdownFormField<ItemSupplier>(
              //   decoration:  InputDecoration(
              //     border: const OutlineInputBorder(),
              //     suffixIcon: const Icon(Icons.arrow_drop_down),
              //     labelText:  (supplierPro.edit) ? supplierPro.selectedSupplier==null?'Supplier' :supplierPro.selectedSupplier!.name : 'Supplier',
              //   ),
              //   onChanged: (dynamic str) => supplierPro.onSupplierUpdate(str),
              //   validator: (dynamic str) {
              //     if (supplierPro.selectedSupplier == null) {
              //       return 'Select Supplier';
              //     }
              //     return null;
              //   },
              //   displayItemFn: (dynamic value) => Text(
              //     value?.name ?? '',
              //     style: const TextStyle(fontSize: 16),
              //   ),
              //   findFn: (dynamic str) async => supp,
              //   filterFn: (dynamic value, String str) =>
              //       value.name.toLowerCase().indexOf(str.toLowerCase()) >= 0,
              //   dropdownItemFn: (dynamic value, int position, bool focused,
              //           dynamic lastSelectedItem, dynamic onTap) =>
              //       ListTile(
              //     title: Text(value.name),
              //     onTap: onTap,
              //   ),
              // ),
            ),
        ),
       supplierPro.edit
            ? const SizedBox()
            : IconButton(
            onPressed: () {
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
