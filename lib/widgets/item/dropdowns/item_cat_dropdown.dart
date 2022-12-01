import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/categories_api.dart';
import '../../../function/time_date_function.dart';
import '../../../models/item/item_category.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_textformfield.dart';
import '../../custom_widgets/custom_toast.dart';

class ItemCatDropdown extends StatefulWidget {
  const ItemCatDropdown({super.key});

  @override
  State<ItemCatDropdown> createState() => _ItemCatDropdownState();
}

class _ItemCatDropdownState extends State<ItemCatDropdown> {
  final TextEditingController _categories = TextEditingController();
  uploadcategories(BuildContext context) async {
    ItemCatProvider catProvider =
        Provider.of<ItemCatProvider>(context, listen: false);
    ItemCategory value = ItemCategory(
        catID: TimeStamp.timestamp.toString(),
        title: _categories.text,
        subCategories: []);
    catProvider.updateCategory(value);
    
    bool temp = await CategoriesAPI().add(value);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'ok');
      _categories.clear();
    }
  }

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
          child: Consumer<ItemCatProvider>(
              builder: (BuildContext context, ItemCatProvider catPro, _) {
            final List<ItemCategory> cats = catPro.category;
            return Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
              child: DropdownFormField<ItemCategory>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: 'Category',
                ),
                onChanged: (dynamic str) => catPro.updateCatSelection(str),
                validator: (dynamic str) {
                  if (catPro.selectedCategroy == null) {
                    return 'Select Category';
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
        IconButton(
            onPressed: () {
            
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add Categories'),
                  content: CustomTextFormField(
                    controller: _categories,
                    hint: 'categories ',
                    validator: (value) => CustomValidator.lessThen2(value),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        uploadcategories(context);
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
