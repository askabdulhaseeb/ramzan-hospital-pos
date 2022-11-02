import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/item/item_category.dart';
import '../../../providers/item_category_provider.dart';
import '../../../utilities/utilities.dart';

class ItemCatDropdown extends StatelessWidget {
  const ItemCatDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Utlities.titleWidth,
          child: Text(
            'Category',
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
              final List<ItemCategory> cats = catPro.category;
              return DropdownButton<ItemCategory>(
                hint: const Text('-- select --'),
                isExpanded: true,
                borderRadius: BorderRadius.circular(Utlities.tileBorderRadius),
                underline: const SizedBox(),
                isDense: true,
                value: catPro.selectedCategroy,
                items: cats
                    .map((ItemCategory e) => DropdownMenuItem<ItemCategory>(
                          value: e,
                          child: Text(e.title),
                        ))
                    .toList(),
                onChanged: (ItemCategory? value) =>
                    catPro.updateCatSelection(value),
              );
            }),
          ),
        ),
      ],
    );
  }
}
