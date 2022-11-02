import 'package:cloud_firestore/cloud_firestore.dart';

class ItemFormula {
  ItemFormula({
    required this.id,
    required this.formula,
  });

  final String id;
  final String formula;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'formula': formula,
    };
  }

  // ignore: sort_constructors_first
  factory ItemFormula.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ItemFormula(
      id: doc.data()?['id'] ?? '',
      formula: doc.data()?['formula'] ?? '',
    );
  }
}
