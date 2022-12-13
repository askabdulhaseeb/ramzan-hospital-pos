import 'package:flutter/cupertino.dart';
import '../function/time_date_function.dart';
import 'item/cart_item.dart';


class Slip {
  factory Slip.fromDataBase(Map<String, dynamic> data, BuildContext context) {
    return Slip(
      slipID: data['slip_id'] ?? 'null',
      
      patientID: data['patient_id'] ?? 'null',
     
      totalbill: data['total_bill'] ?? 0,
     customerDiscount: data['customer_discount'] ?? 0,
     adjustment: data['adjustment'] ?? 0,
     // test: CartItem.fromMap((data['test'] ?? <dynamic>[])),
      timestamp: data['timestamp'] ?? 0,
      test: List<CartItem>.from(data['test'] ?? <CartItem>[]),
    );
  }
  Slip({
    required this.slipID,

    required this.patientID,
 
    required this.totalbill,
    required this.customerDiscount,
    required this.adjustment,

    required this.test,

    this.timestamp,
  });
  final String slipID;
  final String patientID;
  final double totalbill;
   final double customerDiscount;
    final double adjustment;
  final List<CartItem> test;
  final int? timestamp;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'slip_id': slipID,
        
        'patient_id': patientID,
     
        'total_bill': totalbill,
       'adjustment':adjustment,
        'customer_discount':customerDiscount,
        'test': test.map((CartItem e) => e.toMap()).toList(),
        'timestamp': TimeStamp.timestamp,
      };
}
