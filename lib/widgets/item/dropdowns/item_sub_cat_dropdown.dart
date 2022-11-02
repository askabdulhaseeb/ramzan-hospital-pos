import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_sub_category.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../utilities/utilities.dart';

class ItemSubCatDropdown extends StatelessWidget {
  const ItemSubCatDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Utlities.titleWidth,
            child: Text(
              'Sub Category',
              style: Utlities.itemTitleTextStyle,
            ),
          ),
          Expanded(
            child: Consumer<ItemCatProvider>(
                builder: (BuildContext context, ItemCatProvider catPro, _) {
              final List<ItemSubCategory> cats = catPro.subCategory;
              return Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 8, top: 4, bottom: 4),
                child: DropdownFormField<ItemSubCategory>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: 'Sub Category',
                  ),
                  onChanged: (dynamic str) =>
                      catPro.updateSubCategorySection(str),
                  validator: (dynamic str) {
                    if (catPro.selectedCategroy == null) {
                      return 'Select Sub Category';
                    }
                    return null;
                  },
                  displayItemFn: (dynamic value) => Text(
                    value?.title ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  findFn: (dynamic str) async => cats,
                  filterFn: (dynamic value, String str) =>
                      value.title.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                  dropdownItemFn: (dynamic value, int position, bool focused,
                          dynamic lastSelectedItem, dynamic onTap) =>
                      ListTile(
                    title: Text(value.title),
                    onTap: onTap,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
