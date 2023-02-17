import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
