import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/transaction.dart';
import '../../providers/cart_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/patient_provider.dart';
import '../../providers/sale_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/user_provider.dart';
import '../../utilities/custom_validator.dart';

import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/data_table/data_table.dart';

import '../../widgets/sale/sale_bottom.dart';
import '../../widgets/sale/search_medicine.dart';
import '../../widgets/sale/search_patient.dart';
import '../../widgets/sale/transaction_widget.dart';
import '../add_item/add_item_screen.dart';
import 'sale_total_side.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);
  static const String routeName = '/sale-screen';

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final TextEditingController _barcode = TextEditingController();
  final TextEditingController _quantity = TextEditingController(text: '1');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                const Text('Add Medicines : '),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        // ignore: always_specify_types
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddItemScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color!,
                            ),
                          ),
                          child: Text(
                            'Ramzan Clinic & Eye Wear',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Consumer5<UserProvider, ItemProvider, SaleProvider,
                            CartProvider, PatientProvider>(builder: (
                          BuildContext context,
                          UserProvider userPro,
                          ItemProvider itemPro,
                          SaleProvider salePro,
                          CartProvider cartPro,
                          PatientProvider patientPro,
                          _,
                        ) {
                          return Form(
                            key: _formKey,
                            child: Row(
                              children: <Widget>[
                                const Text('Quantity'),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 35,
                                  width: 150,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.search,
                                    onFieldSubmitted: (String value) {},
                                    autofocus: true,
                                    controller: _quantity,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 5.0),
                                      ),
                                      hintText: 'Qty ',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                    ),
                                    validator: (String? value) =>
                                        CustomValidator.isEmpty(value),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                              content: Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                  double height =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height;
                                                  double width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;

                                                  return SizedBox(
                                                    height: height - 100,
                                                    width: width / 3,
                                                    //child: AddPatientUi(),
                                                    child: SearchMedicine(
                                                      quantity: _quantity.text,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(3)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const <Widget>[
                                        Text(
                                          'Search medicine',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                searchPatientWidget(context),
                              ],
                            ),
                          );
                        }),
                        Consumer2<PatientProvider, TransactionProvider>(builder:
                            (BuildContext context,
                                PatientProvider patientpro,
                                TransactionProvider transactionPro,
                                Widget? snapshot) {
                          List<Transaction> transactions = transactionPro
                              .searchUser(patientpro.selectedpatient.patientID);
                          return patientpro.selectedpatient.name == 'unknown'
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            'Patient Name: ${patientpro.selectedpatient.name}'),
                                        Text(
                                            'Mobile No: ${patientpro.selectedpatient.phoneNumber}')
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  content: Builder(
                                                    builder:
                                                        (BuildContext context) {
                                                      double height =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height;
                                                      double width =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width;

                                                      return SizedBox(
                                                        height: height - 100,
                                                        width: width / 3,
                                                        //child: AddPatientUi(),
                                                        child:
                                                            TransactionsSearch(
                                                          transactions:
                                                              transactions,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ));
                                      },
                                      child: const Text('Record'),
                                    )
                                  ],
                                );
                        }),
                      ],
                    ),
                  ),
                  const Expanded(child: CustomDataTable()),
                  const SaleBottom(),
                ],
              ),
            ),
            const SaleTotalSide()
          ],
        ),
      ),
    );
  }

  GestureDetector searchPatientWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (BuildContext context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      double height = MediaQuery.of(context).size.height;
                      double width = MediaQuery.of(context).size.width;

                      return SizedBox(
                        height: height - 100,
                        width: width / 3,
                        //child: AddPatientUi(),
                        child: const PatientSearchUi(),
                      );
                    },
                  ),
                ));
      },
      child: Consumer<PatientProvider>(
          builder: (BuildContext context, PatientProvider patientPro, _) {
        return Container(
          height: 35,
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(3)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              patientPro.selectedpatient.name == 'unknown'
                  ? const Text(
                      'Search the patient',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text(
                      patientPro.selectedpatient.name,
                      style: const TextStyle(color: Colors.grey),
                    ),
              const Icon(
                Icons.search,
                color: Colors.grey,
              )
            ],
          ),
        );
      }),
    );
  }
}
