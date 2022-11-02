import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramzan Hospital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddItemScreen(),
      routes: <String, WidgetBuilder>{
        AddItemScreen.routeName: (_) => const AddItemScreen(),
      },
    );
  }
}
