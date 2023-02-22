import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/item_api/categories_api.dart';
import '../../../models/item/item_category.dart';
import '../../../models/item/item_sub_category.dart';
import '../../../providers/cart_provider.dart';
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
    ItemCatProvider catPro = Provider.of<ItemCatProvider>(context);
    final List<ItemSubCategory> subCart = catPro.subCategory;
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
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 8, top: 4, bottom: 4),
                   child: DropdownButtonFormField<ItemSubCategory>(
                 // isExpanded: true,
                       decoration: const InputDecoration(
                border:OutlineInputBorder(),
                //suffixIcon: Icon(Icons.arrow_drop_down),
                    // labelText: (catPro.edit)
                    //   // ignore: unnecessary_null_comparison
                    //   ? catPro.selectedSubCategory == null
                    //       ? 'sub category'
                    //       : catPro.selectedSubCategory!.title
                    //   : 'sub category',
                // labelText:
                //     (catPro.edit) ? catPro.selectedCategroy==null?'category' :catPro.selectedCategroy!.title : 'category',
              ),
                alignment: Alignment.centerLeft,
               value:catPro .selectedSubCategory,
                style: const TextStyle(color: Colors.black),
                //underline: const SizedBox(),
                hint: const Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                items:catPro.subCategory.isEmpty?[]: catPro.subCategory
                    .map((ItemSubCategory subCat) => DropdownMenuItem<ItemSubCategory>(
                          value: subCat,
                          child: Text(
                            subCat.title.toUpperCase(),
                            style: const TextStyle(),
                          ),
                        ))
                    .toList(),
                onChanged: (ItemSubCategory? value) =>
                    catPro. updateSubCategorySection(value!),
              ),
              // child: DropdownFormField<ItemSubCategory>(
              //   decoration: InputDecoration(
              //     border: const OutlineInputBorder(),
              //     suffixIcon: const Icon(Icons.arrow_drop_down),
              //     labelText: (catPro.edit)
              //         // ignore: unnecessary_null_comparison
              //         ? catPro.selectedSubCategory == null
              //             ? 'sub category'
              //             : catPro.selectedSubCategory!.title
              //         : 'sub category',
              //   ),
              //   onChanged: (dynamic str) =>
              //       catPro.updateSubCategorySection(str),
              //   validator: (dynamic str) {
              //     if (catPro.selectedCategroy == null) {
              //       return 'Select Sub Category';
              //     }
              //     return null;
              //   },
              //   displayItemFn: (dynamic value) => Text(
              //     value?.title ?? '',
              //     style: const TextStyle(fontSize: 16),
              //   ),
              //   findFn: (dynamic str) async => cats,
              //   filterFn: (dynamic value, String str) =>
              //       value.title.toLowerCase().indexOf(str.toLowerCase()) >= 0,
              //   dropdownItemFn: (dynamic value, int position, bool focused,
              //           dynamic lastSelectedItem, dynamic onTap) =>
              //       ListTile(
              //     title: Text(value.title),
              //     onTap: onTap,
              //   ),
              // ),
            ),
          ),
          (catPro.edit)
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Add Sub Categories'),
                        content: CustomTextFormField(
                          controller: _subcategories,
                          hint: 'sub categories ',
                          validator: (value) =>
                              CustomValidator.lessThen2(value),
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
