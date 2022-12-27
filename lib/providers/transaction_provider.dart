import 'package:flutter/cupertino.dart';

import '../database/trasnaction_api.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  TransactionProvider() {
    loadData();
  }
  List<Transaction> _transaction = [];
  List<Transaction> get transaction => _transaction;

  Future<void> loadData() async {
    _transaction = await TransactionAPI().get();
    notifyListeners();
  }

  List<Transaction> searchUser(String userId) {
    List<Transaction> temp = [];
    for (int i = 0; i < _transaction.length; i++) {
      if (userId == _transaction[i].patientID) {
        temp.add(_transaction[i]);
      }
    }

    return temp;
  }
}
