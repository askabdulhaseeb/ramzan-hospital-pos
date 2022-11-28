import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'screens/add_item/add_item_screen.dart';
import 'screens/sale_screen/sale_screen.dart';
import 'screens/screens.dart';

const apiKey = 'AIzaSyD8-XxjB82a_20VvqUR0ljtCjy9KL4MICU';
const projectID = 'temporary-project-f558a';
void main() {
  Firestore.initialize(projectID);
  FirebaseAuth.initialize(apiKey, VolatileStore());
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
        home: const AddItemScreen(),
        routes: registeredRoutes,
      ),
    );
  }
}
