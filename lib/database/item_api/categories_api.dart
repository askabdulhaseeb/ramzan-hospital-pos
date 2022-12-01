import 'package:firedart/firedart.dart';

import '../../models/item/item_category.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class CategoriesAPI {
  CollectionReference collection = Firestore.instance.collection('categories');

  Future<bool> add(ItemCategory value) async {
    String res = 'start';
    try {
     
      await collection.document(value.catID).set(value.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ItemCategory>> get() async {
    List<ItemCategory> value = <ItemCategory>[];
    List<Document> lis = (await collection.get());
    for (int i = 0; i < lis.length; i++) {
      value.add(ItemCategory.fromDoc(lis[i].map));
    }
    return value;
  }

  Future<bool> addSubCat(ItemCategory value) async {
    try {
      await collection.document(value.catID).update(value.addSubCat());
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      return false;
    }
  }
}
