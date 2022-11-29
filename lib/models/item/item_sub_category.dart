import 'package:flutter/src/widgets/framework.dart';

class ItemSubCategory {
  ItemSubCategory({
    required this.subCatID,
    required this.title,
  });

  final String subCatID;
  final String title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_cat_id': subCatID,
      'title': title,
    };
  }

  // ignore: sort_constructors_first
  factory ItemSubCategory.fromMap(Map<String, dynamic> map) {
    return ItemSubCategory(
      subCatID: map['sub_cat_id'] ?? '',
      title: map['title'] ?? '',
    );
  }
}