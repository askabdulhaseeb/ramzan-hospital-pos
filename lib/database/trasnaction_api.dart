import 'package:firedart/firedart.dart';

import '../models/transaction.dart';

class TransactionAPI {
  CollectionReference collection = Firestore.instance.collection('slip');
  Future<bool> add(Transaction value) async {
    bool res = false;
    try {
      await collection.document(value.transactionId).set(value.toMap());
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  Future<List<Transaction>> get() async {
    List<Transaction> transactions = <Transaction>[];
    List<Document> lis =
        (await collection.orderBy('timestamp', descending: true).get());
    for (int i = 0; i < lis.length; i++) {
      transactions.add(Transaction.fromMap(lis[i].map));
    }
    return transactions;
  }
}
