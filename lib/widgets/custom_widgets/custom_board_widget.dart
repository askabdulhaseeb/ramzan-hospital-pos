import 'package:flutter/material.dart';

class CustomBoardWidget extends StatelessWidget {
  const CustomBoardWidget({
    required this.child,
    required this.title,
    this.width,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final String title;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(title),
          ),
          Container(
            width: width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey, width: 0.5),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
