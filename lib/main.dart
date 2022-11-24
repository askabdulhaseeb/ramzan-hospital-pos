import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'screens/add_item/add_item_screen.dart';
import 'screens/sale_screen/sale_screen.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listOfProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ramzan Hospital',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SaleScreen(),
        routes: registeredRoutes,
      ),
    );
  }
}
