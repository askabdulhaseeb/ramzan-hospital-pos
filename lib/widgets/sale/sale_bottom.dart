import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/item/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/patient_provider.dart';
import '../../providers/slip_provider.dart';

class SaleBottom extends StatelessWidget {
  const SaleBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<SlipProvider, PatientProvider, CartProvider>(builder:
        (BuildContext context, SlipProvider slipPro, PatientProvider patientPro,
            CartProvider cartPro, snapshot) {
      String patientID = patientPro.selectedpatient.patientID;
      List<CartItem> test = cartPro.cartItem;
      double totalBill = cartPro.netTotal();
      double customerDiscount = cartPro.customerDiscount;
      double adjustment = cartPro.adjustment;
      return GestureDetector(
        onTap: () async {
          await slipPro.addslip(
              patientID, totalBill, test, customerDiscount, adjustment);
          cartPro.emptyCart();
        },
        child: Container(
          height: 160,
          width: double.infinity,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: const Text(
                  'Print',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
