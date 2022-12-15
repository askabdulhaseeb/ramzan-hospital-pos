import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/item/item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/patient_provider.dart';
import '../../providers/sale_provider.dart';
import '../../providers/user_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/title_textformfield.dart';
import '../../widgets/data_table/data_table.dart';
import '../../widgets/sale/add_patient.dart';
import '../../widgets/sale/sale_bottom.dart';
import '../../widgets/sale/search_patient.dart';
import 'sale_total_side.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);
  static const String routeName = '/sale-screen';

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  TextEditingController _barcode = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sale Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
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
                            'Ranzan Hospital',
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
                                const Text('salesman'),
                                const SizedBox(width: 10),
                                TitleTextFormField(
                                  controller: _quantity,
                                  title: 'Qty',
                                  width: 100,
                                  validator: (String? value) =>
                                      CustomValidator.isEmpty(value),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomTextFormField(
                                  width: 140,
                                  height: 35,
                                  hint: 'barcode add',
                                  controller: _barcode,
                                  color: Colors.white,
                                  validator: (String? value) =>
                                      CustomValidator.isEmpty(value),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    Item? item = itemPro.item(_barcode.text);

                                    if (item == null) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('No item Found'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      cartPro.addtocart(
                                          item, int.parse(_quantity.text));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                                                    child: PatientSearchUi(),
                                                  );
                                                },
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const <Widget>[
                                        Text(
                                          'Search the patient',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Icon(Icons.search)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                        Consumer<PatientProvider>(builder:
                            (context, PatientProvider patientpro, snapshot) {
                          return patientpro.selectedpatient.name == 'unknown'
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        'Patient Name: ${patientpro.selectedpatient.name}'),
                                    Text(
                                        'Mobile No: ${patientpro.selectedpatient.phoneNumber}')
                                  ],
                                );
                        }),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: CustomDataTable(),
                  ),
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
}
