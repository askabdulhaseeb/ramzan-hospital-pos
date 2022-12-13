import 'package:flutter/cupertino.dart';

import '../database/slip_api.dart';
import '../models/item/cart_item.dart';
import '../models/patient.dart';
import '../models/slip.dart';

class SlipProvider with ChangeNotifier {
  Future<void> addslip(
      String patientID, double totalbill, List<CartItem> test,double customerDiscount,double adjustment) async {
    _slip = Slip(
        slipID: '123', patientID: patientID, totalbill: totalbill, test: test,adjustment: adjustment,customerDiscount: customerDiscount);
    bool temp = await SlipAPI().add(_slip);
    if (temp) {
      print('uploaded');
    }
  }

  late Slip _slip;

  Slip get slip => _slip;
}
