import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../database/item_api/categories_api.dart';
import '../../models/item/item_category.dart';
import '../../models/item/item_sub_category.dart';
import 'edit_item_provider.dart';

class ItemCatProvider extends ChangeNotifier {
  ItemCatProvider() {
    loadData();
  }
  updatecart(EditItemProvider editPro) {
    if (editPro.editItem.name == 'null') {
    } else {
      for (int i = 0; i < category.length; i++) {
        if (category[i].catID == editPro.editItem.category) {
          for (int j = 0; j < category[i].subCategories.length; j++) {
            if (category[i].subCategories[j].subCatID ==
                editPro.editItem.subCategory) {
              _selectedSubCat = category[i].subCategories[j];
            }
            break;
          }
          _selectedCat = category[i];
          edit = true;
          
          break;
        }
      }
     
    }
    notifyListeners();
  }

  ItemCategory? _selectedCat;
  List<ItemSubCategory> _subCategory = <ItemSubCategory>[];
  ItemSubCategory? _selectedSubCat;

  List<ItemCategory> _cat = <ItemCategory>[];

  loadData() async {
    _cat = await CategoriesAPI().get();

    notifyListeners();
  }

  updateCategory(ItemCategory value) {
    _cat.add(value);
    //_selectedSubCat = value.subCategories[0];
    notifyListeners();
  }

  updatesubCategory(ItemSubCategory value) {
    _selectedCat!.subCategories.add(value);
    notifyListeners();
  }

  List<ItemCategory> get category => <ItemCategory>[..._cat];
  List<ItemSubCategory> get subCategory => <ItemSubCategory>[..._subCategory];
  ItemCategory? get selectedCategroy => _selectedCat;
  ItemSubCategory? get selectedSubCategory => _selectedSubCat;
  bool edit = false;

  void updateCatSelection(ItemCategory? updatedCategroy) {
    _selectedCat = updatedCategroy;
    _subCategory = updatedCategroy == null
        ? <ItemSubCategory>[]
        : updatedCategroy.subCategories;
    _selectedSubCat = null;
    notifyListeners();
  }

  void updateSubCategorySection(ItemSubCategory? update) {
    _selectedSubCat = update;
    notifyListeners();
  }
}
