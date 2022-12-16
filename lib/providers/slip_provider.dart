import 'package:flutter/cupertino.dart';

import '../database/slip_api.dart';
import '../function/time_date_function.dart';
import '../models/item/cart_item.dart';
import '../models/patient.dart';
import '../models/slip.dart';

class SlipProvider with ChangeNotifier {
  Future<void> addslip(String patientID, double totalbill, List<CartItem> test,
      double customerDiscount, double adjustment, double amountPaid) async {
    bool isPaid = false;
    double total = totalbill + adjustment - customerDiscount;
    if (amountPaid < total) {
      isPaid = false;
    } else {
      isPaid = true;
      amountPaid = total;
    }

    Slip a = Slip(
        slipID: TimeStamp.timestamp.toString(),
        patientID: patientID,
        totalbill: totalbill,
        test: test,
        adjustment: adjustment,
        amountPaid: amountPaid,
        timestamp: TimeStamp.timestamp,
        isPaid: isPaid,
        customerDiscount: customerDiscount);
    _slip = a;
    notifyListeners();
    bool temp = await SlipAPI().add(_slip);
    if (temp) {
      //print('uploaded');
    }
  }

  late Slip _slip;

  Slip get slip => _slip;
}
