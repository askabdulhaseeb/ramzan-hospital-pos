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
  factory ItemManufacturer.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemManufacturer(
      id: doc.data()?['id'] ?? '',
      name: doc.data()?['name'] ?? '',
    );
  }
}
