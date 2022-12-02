import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';

class SaleTotalSide extends StatefulWidget {
  const SaleTotalSide({
    Key? key,
  }) : super(key: key);

  @override
  State<SaleTotalSide> createState() => _SaleTotalSideState();
}

class _SaleTotalSideState extends State<SaleTotalSide> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    CartProvider cartPro = Provider.of<CartProvider>(context);

    return Container(
      width: 300,
      color: const Color(0xff9bcdc6),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: height * 0.1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              totalWidgets('Gross Total', cartPro.totalNetPrice),
              totalWidgets('Discount', cartPro.totalDiscount),
              customDiscountWidget('Customer Discount', cartPro),
              totalWidgets('Net Gross Total', cartPro.grossTotal()),
              adjustmentWidgets('Adjustment', cartPro),
              totalWidgets('Sales tax', 0),
              SizedBox(
                height: height * 0.2,
              ),
              netTotal(cartPro.netTotal())
            ],
          ),
        ),
      ),
    );
  }

  Widget netTotal(double amount) {
    return Column(
      children: [
        const Text(
          'Net Total',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(child: Text(amount.toString())),
          ),
        )
      ],
    );
  }

  Widget totalWidgets(String text, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 140,
            height: 30,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(amount.toString()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget adjustmentWidgets(String text, CartProvider cartPro) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 140,
            height: 30,
            child: TextField(
                decoration: InputDecoration(
                  hintText: cartPro.adjustment.toString(),
                  enabledBorder: const OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  if (value.isEmpty) {
                    cartPro.adjustmentUpdate('0');
                  } else {
                    cartPro.adjustmentUpdate(value);
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget customDiscountWidget(String text, CartProvider cartPro) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 140,
            height: 30,
            child: TextField(
                decoration: InputDecoration(
                  hintText: cartPro.customerDiscount.toString(),
                  enabledBorder: const OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  if (value.isEmpty) {
                    cartPro.customerDiscountUpdate('0');
                  } else {
                    cartPro.customerDiscountUpdate(value);
                  }
                }),
          )
        ],
      ),
    );
  }
}
