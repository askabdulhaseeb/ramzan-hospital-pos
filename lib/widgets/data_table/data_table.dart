import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

/// Example without a datasource
class CustomDataTable extends StatefulWidget {
  const CustomDataTable({super.key});

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final CartProvider cartPro = Provider.of<CartProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,

            // ignore: always_specify_types
            columns: const [
              DataColumn(
                label: Text('''Sr #'''),
              ),
              DataColumn(
                label: Text('Poduct Code'),
              ),
              DataColumn(
                label: Text('Product name'),
              ),
              DataColumn(
                label: Text('Batch no'),
              ),
              DataColumn(
                label: Text('Rate'),
              ),
              DataColumn(
                label: Text('Qty'),
              ),
              DataColumn(
                label: Text('Price'),
              ),
              DataColumn(
                label: Text('Discount'),
              ),
              DataColumn(
                label: Text('Total'),
              ),
              DataColumn(
                label: Text('Delete'),
              ),
            ],
            rows: List<DataRow>.generate(
                cartPro.cartItem.length,
                (int index) => DataRow(cells: <DataCell>[
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(
                        cartPro.item[index].code,
                      )),
                      DataCell(Text(
                        cartPro.item[index].name,
                      )),
                      const DataCell(Text(
                        '',
                      )),
                      DataCell(Text(
                        cartPro.item[index].salePrice.toString(),
                      )),
                      DataCell(Text(
                        cartPro.cartItem[index].quantity.toString(),
                      )),
                      DataCell(Text(
                        cartPro.cartItem[index].price.toString(),
                      )),
                      DataCell(
                        SizedBox(
                          width: 40,
                          child: TextField(
                              decoration: InputDecoration(
                                hintText:
                                    cartPro.cartItem[index].discount.toString(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              onChanged: (String value) {
                                if (value.isEmpty) {
                                  cartPro.onDiscountUpdate('0', index);
                                } else {
                                  cartPro.onDiscountUpdate(value, index);
                                }
                              }),
                        ),
                      ),
                      DataCell(Text(cartPro
                          .afterDiscountTestPrice(cartPro.cartItem[index])
                          .toString())),
                      DataCell(
                        IconButton(
                          onPressed: () {},
                          splashRadius: 16,
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ]))),
      ),
    );
  }
}
