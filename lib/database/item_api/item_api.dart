import 'package:firedart/firedart.dart';

import '../../models/item/item.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class ItemAPI {
  CollectionReference collection = Firestore.instance.collection('items');

  Future<bool> add(Item value) async {
    try {
      await collection.document(value.id).set(value.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(
          message: 'Some Error occured when categories added');
      return false;
    }
  }

  Future<List<Item>> get() async {
    List<Item> value = <Item>[];
    List<Document> lis = (await collection.get());
    for (int i = 0; i < lis.length; i++) {
      value.add(Item.fromMap(lis[i].map));
    }
    return value;
  }
}
