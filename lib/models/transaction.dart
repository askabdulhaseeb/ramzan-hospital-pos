// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  final String transactionId;
  final String slipId;
  final String patientID;
  final double totalbill;
  final double amountPaid;
  final double remainingBill;
  final int timestamp;
  Transaction({
    required this.transactionId,
    required this.slipId,
    required this.patientID,
    required this.totalbill,
    required this.amountPaid,
    required this.remainingBill,
    required this.timestamp,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'slipId': slipId,
      'patientID': patientID,
      'totalbill': totalbill,
      'amountPaid': amountPaid,
      'remainingBill': remainingBill,
      'timestamp': timestamp,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionId: map['transactionId'] as String,
      slipId: map['slipId'] as String,
      patientID: map['patientID'] as String,
      totalbill: map['totalbill'] as double,
      amountPaid: map['amountPaid'] as double,
      remainingBill: map['remainingBill'] as double,
      timestamp: map['timestamp'] as int,
    );
  }

 
}
