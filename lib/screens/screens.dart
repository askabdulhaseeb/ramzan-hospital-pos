import 'package:flutter/material.dart';

import 'add_item/add_item_screen.dart';
import 'sale_screen/sale_screen.dart';

Map<String, WidgetBuilder> get registeredRoutes => <String, WidgetBuilder>{
      AddItemScreen.routeName: (_) => const AddItemScreen(),
      SaleScreen.routeName: (_) => const SaleScreen(),
    };
