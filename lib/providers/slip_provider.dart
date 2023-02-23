import 'package:flutter/cupertino.dart';

import '../database/slip_api.dart';
import '../database/trasnaction_api.dart';
import '../function/time_date_function.dart';
import '../models/item/cart_item.dart';
import '../models/patient.dart';
import '../models/slip.dart';
import '../models/transaction.dart';

class SlipProvider with ChangeNotifier {

   SlipProvider() {
    loadData();
  }
  List<Slip> _slipList = [];
  List<Slip> get slipList => _slipList;

  Future<void> loadData() async {
    _slipList = await SlipAPI().get();
    notifyListeners();
  }
    List<Slip> searchUser(String userId) {
    List<Slip> temp = [];
    for (int i = 0; i < _slipList.length; i++) {
      if (userId == _slipList[i].patientID) {
        temp.add(_slipList[i]);
      }
    }

    return temp;
  }
  Slip getSlip(String id){
    int index= _slipList.indexWhere((Slip element) => element.slipID==id);
    return index<0? _null:slipList[index];
  }
  Slip _null=Slip(slipID: '', patientID: '', totalbill: 0, customerDiscount:0, adjustment: 0, amountPaid: 0, isPaid: false, test: []);
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
    double remaningBill = total - amountPaid;
    if (remaningBill < 0) {
      remaningBill = 0;
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
    Transaction transaction = Transaction(
        transactionId: TimeStamp.timestamp.toString(),
        slipId: a.slipID,
        patientID: patientID,
        totalbill: total,
        amountPaid: amountPaid,
        remainingBill: remaningBill,
        timestamp: TimeStamp.timestamp);
    _slip = a;
    notifyListeners();
    bool temp = await SlipAPI().add(_slip);
    bool isTransaction = await TransactionAPI().add(transaction);
    if (temp) {
      //print('uploaded');
    }
  }

  late Slip _slip;

  Slip get slip => _slip;
}
