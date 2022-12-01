import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/utilities.dart';

class CustomTitleTextField extends StatefulWidget {
  const CustomTitleTextField({
    required TextEditingController controller,
    required this.title,
    required this.value,
    this.titleWidth,
    // required this.onTap,
    Key? key,
  })  : _controller = controller,
        super(key: key);
  final TextEditingController _controller;
  final String title;
  final double? titleWidth;
  final String value;
  //final VoidCallback onTap;

  @override
  CustomTitleTextFieldState createState() =>
      CustomTitleTextFieldState();
}

class CustomTitleTextFieldState extends State<CustomTitleTextField> {
  void _onListen() => setState(() {});
  @override
  void initState() {
    widget._controller.addListener(_onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: SizedBox(
        width: widget.titleWidth ?? Utlities.titleWidth,
        child: Text(
          widget.title,
          style: Utlities.itemTitleTextStyle,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextField(
        controller: widget._controller,
          decoration: InputDecoration(
            hintText: widget.value,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onChanged: (String value) {
            if (value.isEmpty) {
              //cartPro.onDiscountUpdate('0', index);
            } else {
              //cartPro.onDiscountUpdate(value, index);
            }
          }),
    );
  }
}
