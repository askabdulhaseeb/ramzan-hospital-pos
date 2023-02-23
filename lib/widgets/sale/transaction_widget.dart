import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/slip_api.dart';
import '../../database/trasnaction_api.dart';
import '../../function/time_date_function.dart';
import '../../models/patient.dart';
import '../../models/slip.dart';
import '../../models/transaction.dart';
import '../../providers/patient_provider.dart';
import '../../providers/slip_provider.dart';
import '../custom_widgets/custom_textformfield.dart';
import 'add_patient.dart';

class TransactionsSearch extends StatelessWidget {
  TransactionsSearch({required this.slips, super.key});
  final List<Slip> slips;
  final TextEditingController remainingBill=TextEditingController();
  @override
  Widget build(BuildContext context) {
    SlipProvider slipPro=Provider.of<SlipProvider>(context);
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
            itemCount: slips.length,
            itemBuilder: (BuildContext context, int index) {
              Slip slip=slips[index];
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
                    title: Row(
                      children: [
                        Text(
                          TimeStamp.timeindays(slip.timestamp??0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text((slip.totalbill-slip.amountPaid).toString())
                      ],
                    ),
                    trailing: slip.isPaid?const SizedBox(
                      width: 80,
                      child: Text('Paid')):Builder(
                        builder: (BuildContext context) => 
                         ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                         showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Remaining Bill : ${slip.totalbill-slip.amountPaid}'),
                      content: CustomTextFormField(
                        controller: remainingBill,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () async {
                            double amount=double.parse(remainingBill.text);

                            
                              slip.amountPaid+=amount;
        slip.isPaid=slip.amountPaid==slip.totalbill? true:false;
                               Transaction transacti= Transaction(
        transactionId: TimeStamp.timestamp.toString(),
        slipId: slip.slipID,
        patientID: slip.patientID,
        totalbill: slip.totalbill,
        amountPaid: slip.amountPaid,
        remainingBill:  slip.totalbill-slip.amountPaid,
        timestamp: TimeStamp.timestamp);
      
bool temp = await SlipAPI().updateQuantity(slip);
                            bool isTransaction = await TransactionAPI().add(transacti);
                            
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                      
                        },
                        child:  const Text('Remaing'),
                                          ),
                      ),
                  ),
                ),
              );
            }),
      )
    ]);
  }
}
