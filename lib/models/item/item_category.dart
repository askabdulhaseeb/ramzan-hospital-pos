import 'package:cloud_firestore/cloud_firestore.dart';
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

  // ignore: sort_constructors_first
  factory ItemCategory.fromDoc(Map<String, dynamic> map) {
    return ItemCategory(
      catID: map['cat_id'] ?? '',
      title: map['title'] ?? '',
      subCategories: List<ItemSubCategory>.from(map['sub_categories']
          ?.map((Map<String, dynamic> x) => ItemSubCategory.fromMap(x))),
    );
  }
}