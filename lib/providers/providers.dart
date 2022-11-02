import 'package:provider/provider.dart';

import 'item/item_category_provider.dart';
import 'item/item_formula_provider.dart';
import 'item/item_provider.dart';

// ignore: always_specify_types
dynamic get listOfProvider => [
      ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
      ChangeNotifierProvider<ItemCatProvider>(
        create: (_) => ItemCatProvider(),
      ),
      ChangeNotifierProvider<ItemFormulaProvider>(
        create: (_) => ItemFormulaProvider(),
      ),
    ];
