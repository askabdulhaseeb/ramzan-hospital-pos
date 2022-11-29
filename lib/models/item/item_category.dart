import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'item_sub_category.dart';

class ItemCategory {
  ItemCategory({
    required this.catID,
    required this.title,
    required this.subCategories,
  });

  final String catID;
  final String title;
  final List<ItemSubCategory> subCategories;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cat_id': catID,
      'title': title,
      'sub_categories':
          subCategories.map((ItemSubCategory x) => x.toMap()).toList(),
    };
  }

   Map<String, dynamic> addSubCat() {
    return <String, dynamic>{
      'sub_categories':
          subCategories.map((ItemSubCategory x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory ItemCategory.fromDoc(Map<String, dynamic> map) {
    List<ItemSubCategory> subCats = <ItemSubCategory>[];
    // ignore: always_specify_types
    final List<dynamic> data = map['sub_categories'] ?? [];
    for (dynamic element in data) {
      subCats.add(ItemSubCategory.fromMap(element));
    }
    return ItemCategory(
      catID: map['cat_id'] ?? '',
      title: map['title'] ?? '',
      subCategories: subCats,
      //  subCategories: ItemSubCategory.fromMap(map['sub_categories'] ?? <dynamic>[]),
    );
  }
}
