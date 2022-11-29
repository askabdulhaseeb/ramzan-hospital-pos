import 'package:flutter/material.dart';


class CustomToast {


  static void errorSnackBar({
    required BuildContext context,
    required String text,
  }) {
    final SnackBar snackBar =
        SnackBar(content: Text(text), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void successSnackBar({
    required BuildContext context,
    required String text,
  }) {
    final SnackBar snackBar =
        SnackBar(content: Text(text), backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}