import 'package:flutter/cupertino.dart';
import '../function/time_date_function.dart';
import 'item/cart_item.dart';


class Slip {
  factory Slip.fromDataBase(Map<String, dynamic> data) {
    List<CartItem> test=[];
     if (data['test'] != null) {
      data['test'].forEach((dynamic e) {
        test.add(CartItem.fromMap(e));
      });
    }
    return Slip(
      slipID: data['slip_id'] ?? 'null',
      isPaid: data['is_paid']?? false,
      patientID: data['patient_id'] ?? 'null',
     amountPaid:data['amount_paid']??'' ,
      totalbill: data['total_bill'] ?? 0,
     customerDiscount: data['customer_discount'] ?? 0,
     adjustment: data['adjustment'] ?? 0,
     // test: CartItem.fromMap((data['test'] ?? <dynamic>[])),
      timestamp: data['timestamp'] ?? 0,
      test: test,
    );
  }
  Slip({
    required this.slipID,

    required this.patientID,
 
    required this.totalbill,
    required this.customerDiscount,
    required this.adjustment,
   required this.amountPaid,
   required this.isPaid,
    required this.test,

    this.timestamp,
  });
  final String slipID;
  final String patientID;
  final double totalbill;
  final double customerDiscount;
  final double adjustment;
  double amountPaid;
   bool isPaid;
  final List<CartItem> test;
  final int? timestamp;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'slip_id': slipID,
        
        'patient_id': patientID,
        'total_bill': totalbill,
        'amount_paid':amountPaid,
        'is_paid': isPaid,
       'adjustment':adjustment,
        'customer_discount':customerDiscount,
        'test': test.map((CartItem e) => e.toMap()).toList(),
        'timestamp': TimeStamp.timestamp,
      };
      updateQuantity(Slip value){
    return  <String, dynamic>{
      'is_paid': value.isPaid,
      'amount_paid':value.amountPaid,
    };
  }
}
