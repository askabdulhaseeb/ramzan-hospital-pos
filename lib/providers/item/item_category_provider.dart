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
    log(editPro.editItem.name);
    if (editPro.editItem.name == 'null') {
    } else {
      for (int i = 0; i < category.length; i++) {
        if (category[i].catID == editPro.editItem.category) {
          print(category[i].title);
          _selectedCat = category[i];
          break;
        }
      }
      for (int i = 0; i < _subCategory.length; i++) {
        if (_subCategory[i].subCatID == editPro.editItem.category) {
          print(_subCategory[i].title);
          _selectedSubCat = _subCategory[i];
          break;
        }
      }
    }
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
