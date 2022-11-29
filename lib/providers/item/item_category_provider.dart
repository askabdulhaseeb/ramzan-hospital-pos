import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../database/item_api/categories_api.dart';
import '../../models/item/item_category.dart';
import '../../models/item/item_sub_category.dart';

class ItemCatProvider extends ChangeNotifier {
  ItemCatProvider() {
    loadData();
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
