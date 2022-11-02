import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_category.dart';
import '../../../models/item/item_manufacturer.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../providers/item/item_manufacturer_provider.dart';
import '../../../utilities/utilities.dart';

class ItemManufacturerDropdown extends StatelessWidget {
  const ItemManufacturerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Manufacturer',
            style: Utlities.itemTitleTextStyle,
          ),
        ),
        Expanded(
          child: Consumer<ItemManufacturerProvider>(builder:
              (BuildContext context, ItemManufacturerProvider manuPro, _) {
            final List<ItemManufacturer> manu = manuPro.manufacturer;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
              child: DropdownFormField<ItemManufacturer>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: 'Manufacturer',
                ),
                onChanged: (dynamic str) => manuPro.onManufacturerUpdate(str),
                validator: (dynamic str) {
                  if (manuPro.selectedManufacturer == null) {
                    return 'Select Manufacturer';
                  }
                  return null;
                },
                displayItemFn: (dynamic value) => Text(
                  value?.name ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                findFn: (dynamic str) async => manu,
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
