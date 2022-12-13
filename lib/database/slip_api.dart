
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
}
