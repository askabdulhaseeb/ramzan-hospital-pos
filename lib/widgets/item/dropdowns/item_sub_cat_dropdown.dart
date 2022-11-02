import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_sub_category.dart';
import '../../../providers/item_category_provider.dart';
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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              margin: const EdgeInsets.only(left: 18, right: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(Utlities.tileBorderRadius),
              ),
              child: Consumer<ItemCatProvider>(
                  builder: (BuildContext context, ItemCatProvider catPro, _) {
                final List<ItemSubCategory> cats = catPro.subCategory;
                return DropdownButton<ItemSubCategory>(
                  hint: const Text('-- select --'),
                  isExpanded: true,
                  borderRadius:
                      BorderRadius.circular(Utlities.tileBorderRadius),
                  underline: const SizedBox(),
                  isDense: true,
                  value: catPro.selectedSubCategory,
                  items: cats
                      .map((ItemSubCategory e) =>
                          DropdownMenuItem<ItemSubCategory>(
                            value: e,
                            child: Text(e.title),
                          ))
                      .toList(),
                  onChanged: (ItemSubCategory? value) =>
                      catPro.updateSubCategorySection(value),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
