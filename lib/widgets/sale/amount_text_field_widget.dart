import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField(
      {required this.text, required this.hintText, this.onchange, super.key});
  final String text;
  final String hintText;
  final String? Function(String? value)? onchange;
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
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
          SizedBox(
            width: 140,
            height: 30,
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                hintText: hintText,
                border: const OutlineInputBorder(),
              ),
              onChanged: onchange,

              // (String value) {
              //   if (value.isEmpty) {
              //     cartPro.amountPaidUpdate('0');
              //   } else {
              //     cartPro.amountPaidUpdate(value);
              //   }
              // }
            ),
          )
        ],
      ),
    );
    ;
  }
}
