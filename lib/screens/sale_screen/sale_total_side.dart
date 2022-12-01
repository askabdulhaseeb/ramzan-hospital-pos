import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_textformfield.dart';

class SaleTotalSide extends StatelessWidget {
  const SaleTotalSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: double.infinity,
      width: 300,
      color: const Color(0xff9bcdc6),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            totalWidgets('Gross Total', 15),
            totalWidgets('Discount', 0),
            totalWidgets('Receipt id', 123),
            totalWidgets('Net Gross Total', 15),
            adjustmentWidgets('Adjustment'),
            totalWidgets('Sales tax', 0),
            SizedBox(
              height: height * 0.2,
            ),
            netTotal(15)
          ],
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
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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

  Widget adjustmentWidgets(String text) {
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
          const SizedBox(
            width: 140,
            height: 30,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
