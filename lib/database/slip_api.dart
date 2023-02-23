
import 'package:firedart/firedart.dart';

import '../models/slip.dart';

class SlipAPI {
  CollectionReference collection = Firestore.instance.collection('slip');
  Future<bool> add(Slip slip) async {
    bool res = false;
    try {
      await collection.document(slip.slipID).set(slip.toJson());

      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }
  Future<List<Slip>> get() async {
    List<Slip> slips = <Slip>[];
    List<Document> lis =
        (await collection.orderBy('timestamp', descending: true).get());
    for (int i = 0; i < lis.length; i++) {
      slips.add(Slip.fromDataBase(lis[i].map));
    }
    return slips;
  }
}
