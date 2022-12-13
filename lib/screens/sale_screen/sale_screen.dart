import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/item/item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/sale_provider.dart';
import '../../providers/user_provider.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/title_textformfield.dart';
import '../../widgets/data_table/data_table.dart';
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
                        Consumer4<UserProvider, ItemProvider, SaleProvider,
                            CartProvider>(builder: (
                          BuildContext context,
                          UserProvider userPro,
                          ItemProvider itemPro,
                          SaleProvider salePro,
                          CartProvider cartPro,
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
                                Container(
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
                                )
                              ],
                            ),
                          );
                        }),
                        // Text('Patient Name:'),
                        // Text('Mobile No:')
                      ],
                    ),
                  ),
                  const Expanded(
                    child: CustomDataTable(),
                  ),
                  const SaleButtonSide(),
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

class SaleButtonSide extends StatelessWidget {
  const SaleButtonSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      color: Colors.blue,
    );
  }
}
