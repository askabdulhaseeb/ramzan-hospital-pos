import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/categories_api.dart';
import '../../../models/item/item_category.dart';
import '../../../models/item/item_sub_category.dart';
import '../../../providers/item/item_category_provider.dart';
import '../../../utilities/custom_validator.dart';
import '../../../utilities/utilities.dart';
import '../../custom_widgets/custom_textformfield.dart';

class ItemSubCatDropdown extends StatefulWidget {
  const ItemSubCatDropdown({super.key});

  @override
  State<ItemSubCatDropdown> createState() => _ItemSubCatDropdownState();
}

class _ItemSubCatDropdownState extends State<ItemSubCatDropdown> {
  final TextEditingController _subcategories = TextEditingController();
  uploadsubcategory(BuildContext context) async {
    ItemCatProvider catProvider =
        Provider.of<ItemCatProvider>(context, listen: false);
    ItemSubCategory subCat = ItemSubCategory(
      subCatID: _subcategories.text.toLowerCase(),
      title: _subcategories.text,
    );
    catProvider.selectedCategroy!.subCategories.add(subCat);
    //catProvider.updatesubCategory(subCat);
    bool temp = await CategoriesAPI().addSubCat(catProvider.selectedCategroy!);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'ok');
      _subcategories.clear();
    }
  }

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
          IconButton(
              onPressed: () {
                print('icon button pressed');
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Add Sub Categories'),
                    content: CustomTextFormField(
                      controller: _subcategories,
                      hint: 'sub categories ',
                      validator: (value) => CustomValidator.lessThen2(value),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          uploadsubcategory(context);
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
      ),
    );
  }
}
