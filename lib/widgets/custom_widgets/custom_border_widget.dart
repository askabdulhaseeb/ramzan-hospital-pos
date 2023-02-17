import 'package:flutter/material.dart';

import '../../utilities/utilities.dart';

class CustomBorderWidget extends StatelessWidget {
  const CustomBorderWidget({required this.child, this.maxWidth, super.key});
  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? 300),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
