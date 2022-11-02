import 'package:flutter/material.dart';

import 'add_item/add_item.dart';

Map<String, WidgetBuilder> get registeredRoutes => <String, WidgetBuilder>{
      AddItemScreen.routeName: (_) => const AddItemScreen(),
    };
