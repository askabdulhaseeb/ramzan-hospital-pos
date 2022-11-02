import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/item/item_category.dart';
import '../models/item/item_sub_category.dart';


class ItemCatProvider extends ChangeNotifier {
  ItemCategory? _selectedCat;
  List<ItemSubCategory> _subCategory = <ItemSubCategory>[];
  ItemSubCategory? _selectedSubCat;
  final List<ItemCategory> _cat = <ItemCategory>[
    ItemCategory(
      catID: 'trousers',
      title: 'Trousers',
      subCategories: <ItemSubCategory>[
        ItemSubCategory(subCatID: 'trousers1', title: 'Trousers1'),
        ItemSubCategory(subCatID: 'trousers2', title: 'Trousers2'),
        ItemSubCategory(subCatID: 'trousers3', title: 'Trousers3'),
      ],
    ),
    ItemCategory(
      catID: 'accessories',
      title: 'Accessories',
      subCategories: <ItemSubCategory>[
        ItemSubCategory(subCatID: 'accessories1', title: 'Accessories1'),
        ItemSubCategory(subCatID: 'accessories2', title: 'Accessories2'),
        ItemSubCategory(subCatID: 'accessories3', title: 'Accessories3'),
      ],
    ),
    ItemCategory(
      catID: 'hats',
      title: 'Hats',
      subCategories: <ItemSubCategory>[
        ItemSubCategory(subCatID: 'hats1', title: 'Hats1'),
        ItemSubCategory(subCatID: 'hats2', title: 'Hats2'),
        ItemSubCategory(subCatID: 'hats3', title: 'Hats3'),
      ],
    ),
    ItemCategory(
      catID: 'jewellery',
      title: 'Jewellery',
      subCategories: <ItemSubCategory>[
        ItemSubCategory(subCatID: 'jewellery2', title: 'Jewellery2'),
        ItemSubCategory(subCatID: 'jewellery3', title: 'Jewellery3'),
        ItemSubCategory(subCatID: 'jewellery4', title: 'Jewellery4'),
        ItemSubCategory(subCatID: 'jewellery5', title: 'Jewellery5'),
      ],
    ),
  ];

  List<ItemCategory> get category => <ItemCategory>[..._cat];
  List<ItemSubCategory> get subCategory => <ItemSubCategory>[..._subCategory];
  ItemCategory? get selectedCategroy => _selectedCat;
  ItemSubCategory? get selectedSubCategory => _selectedSubCat;

  void updateCatSelection(ItemCategory updatedCategroy) {
    _selectedCat = updatedCategroy;
    _subCategory = updatedCategroy.subCategories;
    _selectedSubCat = null;
    notifyListeners();
  }

  void updateSubCategorySection(ItemSubCategory update) {
    _selectedSubCat = update;
    notifyListeners();
  }
}