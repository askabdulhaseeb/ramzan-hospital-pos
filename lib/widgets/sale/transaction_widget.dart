import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../function/time_date_function.dart';
import '../../models/patient.dart';
import '../../models/transaction.dart';
import '../../providers/patient_provider.dart';
import 'add_patient.dart';

class TransactionsSearch extends StatelessWidget {
  const TransactionsSearch({required this.transactions, super.key});
  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Theme.of(context).cardColor,
          ),
          child: const Center(child: Text('Transactions')),
        ),
      ),
      const SizedBox(height: 30),
      SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      TimeStamp.timeindays(transactions[index].timestamp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: transactions[index].remainingBill == 0
                          ? const Text('Paid')
                          : const Text('Remaing'),
                    ),
                  ),
                ),
              );
            }),
      )
    ]);
  }
}
