import 'package:firedart/firedart.dart';

import '../../models/item/item_supplier.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class SupplierAPI {
  CollectionReference collection = Firestore.instance.collection('supllier');

  Future<bool> add(ItemSupplier value) async {
    try {
      await collection.document(value.id).set(value.toMap());
      return true;
    } catch (e) {
 
      return false;
    }
  }

  Future<List<ItemSupplier>> get() async {
    List<ItemSupplier> value = <ItemSupplier>[];
    List<Document> lis = (await collection.get());
    for (int i = 0; i < lis.length; i++) {
      value.add(ItemSupplier.fromMap(lis[i].map));
    }
    return value;
  }
}
