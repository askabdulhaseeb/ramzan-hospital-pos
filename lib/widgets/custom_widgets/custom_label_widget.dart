import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/utilities.dart';

class CustomLableWidget extends StatelessWidget {
  const CustomLableWidget({
    required this.lable,
    required this.child,
    this.lableWidth = 80,
    Key? key,
  }) : super(key: key);
  final String lable;
  final Widget child;
  final double lableWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: lableWidth,
            child: Text(
              lable,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
