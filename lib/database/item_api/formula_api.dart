import 'package:firedart/firedart.dart';

import '../../models/item/item.dart';
import '../../models/item/item_formula.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class FormulaAPI {
  CollectionReference collection = Firestore.instance.collection('formula');

  Future<bool> add(ItemFormula value) async {
    try {
      await collection.document(value.id).set(value.toMap());
      return true;
    } catch (e) {
      
      return false;
    }
  }

  Future<List<ItemFormula>> get() async {
    List<ItemFormula> value = <ItemFormula>[];
    List<Document> lis = (await collection.get());
    for (int i = 0; i < lis.length; i++) {
      value.add(ItemFormula.fromMap(lis[i].map));
    }
    return value;
  }
}
