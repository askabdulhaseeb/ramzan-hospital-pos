import 'package:firedart/firedart.dart';
import '../../models/item/item_manufacturer.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class ManufacturerAPI {
  CollectionReference collection = Firestore.instance.collection('manufacturer');

  Future<bool> add(ItemManufacturer value) async {
    try {
      await collection.document(value.id).set(value.toMap());
      return true;
    } catch (e) {
      CustomToast.errorToast(
          message: 'Some Error occured when categories added');
      return false;
    }
  }

  Future<List<ItemManufacturer>> get() async {
    List<ItemManufacturer> value = <ItemManufacturer>[];
    List<Document> lis = (await collection.get());
    for (int i = 0; i < lis.length; i++) {
      value.add(ItemManufacturer.fromMap(lis[i].map));
    }
    return value;
  }
}
