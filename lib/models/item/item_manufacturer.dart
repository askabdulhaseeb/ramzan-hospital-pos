import 'package:cloud_firestore/cloud_firestore.dart';

class ItemManufacturer {
  ItemManufacturer({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  // ignore: sort_constructors_first
  factory ItemManufacturer.fromMap(Map<String, dynamic> map) {
    return ItemManufacturer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
