// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  Item({
    required this.id,
    required this.name,
    required this.code,
    required this.line,
    required this.category,
    required this.subCategory,
    required this.formula,
    required this.manufacturer,
    required this.supplier,
    this.quantity = 0,
    this.averagePrice = 0,
    this.salePrice = 0,
    this.discount = 0,
  });

  final String id;
  final String name;
  final String code;
  final String line;
  final String category;
  final String subCategory;
  final String formula;
  final String manufacturer;
  final String supplier;
  final int quantity;
  final double averagePrice;
  final double salePrice;
  final double discount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'line': line,
      'category': category,
      'sub_category': subCategory,
      'formula': formula,
      'manufacturer': manufacturer,
      'supplier': supplier,
      'quantity': quantity,
      'average_price': averagePrice,
      'sale_price': salePrice,
      'discount': discount,
    };
  }

  factory Item.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Item(
      id: doc.data()?['id'] ?? '',
      name: doc.data()?['name'] ?? '',
      code: doc.data()?['code'] ?? '',
      line: doc.data()?['line'] ?? '',
      category: doc.data()?['category'] ?? '',
      subCategory: doc.data()?['subCategory'] ?? '',
      formula: doc.data()?['formula'] ?? '',
      manufacturer: doc.data()?['manufacturer'] ?? '',
      supplier: doc.data()?['supplier'] ?? '',
      quantity: doc.data()?['quantity'] ?? 0,
      averagePrice: doc.data()?['averagePrice'] ?? 0,
      salePrice: doc.data()?['salePrice'] ?? 0,
      discount: doc.data()?['discount'] ?? 0,
    );
  }
}
