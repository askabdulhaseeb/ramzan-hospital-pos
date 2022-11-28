import 'package:cloud_firestore/cloud_firestore.dart';

class ItemSupplier {
  ItemSupplier({
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
  factory ItemSupplier.fromMap(Map<String, dynamic> map) {
    return ItemSupplier(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
