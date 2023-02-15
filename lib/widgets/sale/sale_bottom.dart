import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:provider/provider.dart';

import '../../models/item/cart_item.dart';
import '../../models/transaction.dart';
import '../../providers/cart_provider.dart';
import '../../providers/item/item_provider.dart';
import '../../providers/patient_provider.dart';
import '../../providers/slip_provider.dart';
import '../pdf/pdf_show.dart';

class SaleBottom extends StatefulWidget {
  const SaleBottom({Key? key}) : super(key: key);

  @override
  State<SaleBottom> createState() => _SaleBottomState();
}

class _SaleBottomState extends State<SaleBottom> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Consumer4<SlipProvider, PatientProvider, CartProvider, ItemProvider>(
        builder: (BuildContext context,
            SlipProvider slipPro,
            PatientProvider patientPro,
            CartProvider cartPro,
            ItemProvider itemPro,
            snapshot) {
      String patientID = patientPro.selectedpatient.patientID;
      List<CartItem> test = cartPro.cartItem;
      double totalBill = cartPro.netTotal();
      double customerDiscount = cartPro.customerDiscount;
      double adjustment = cartPro.adjustment;
      double amountPaid = cartPro.amountPaid;
      return cartPro.cartItem.isNotEmpty
          ? GestureDetector(
              onTap: () async {
                setState(() {
                  isloading = false;
                });
                await slipPro.addslip(patientID, totalBill, test,
                    customerDiscount, adjustment, amountPaid);

                print('length ${slipPro.slip.test.length}');
                print('Slip ID' + slipPro.slip.slipID);
                await PdfInvoiceApi.generate(slipPro, itemPro, context);
                cartPro.emptyCart();
                setState(() {
                  isloading = true;
                });
              },
              child: isloading
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 150,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              alignment: Alignment.center,
                              child: const Text(
                                'Print',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
            )
          : const SizedBox();
    });
  }
}
