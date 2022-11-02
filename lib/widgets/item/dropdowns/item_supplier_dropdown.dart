import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_supplier.dart';
import '../../../providers/item/item_supplier_provider.dart';
import '../../../utilities/utilities.dart';

class ItemSupplierDropdown extends StatelessWidget {
  const ItemSupplierDropdown({super.key});

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
      ],
    );
  }
}
