import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'item/edit_item_provider.dart';
import 'item/item_category_provider.dart';
import 'item/item_formula_provider.dart';
import 'item/item_manufacturer_provider.dart';
import 'item/item_provider.dart';
import 'item/item_supplier_provider.dart';
import 'sale_provider.dart';
import 'user_provider.dart';

// ignore: always_specify_types
dynamic get listOfProvider => [
      ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ChangeNotifierProvider<CartProvider>(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider<ItemFormulaProvider>(
        create: (_) => ItemFormulaProvider(),
      ),
      ChangeNotifierProvider<ItemManufacturerProvider>(
        create: (_) => ItemManufacturerProvider(),
      ),
      ChangeNotifierProvider<ItemSupplierProvider>(
        create: (_) => ItemSupplierProvider(),
      ),
      ChangeNotifierProxyProvider<ItemProvider, EditItemProvider>(
        create: (_) => EditItemProvider(),
        update: (_, ItemProvider itemPro, EditItemProvider? editPro) =>
            editPro!..update(itemPro),
      ),
      ChangeNotifierProxyProvider<EditItemProvider, ItemCatProvider>(
        create: (_) => ItemCatProvider(),
        update: (_, EditItemProvider editPro, ItemCatProvider? cartPro) =>
            cartPro!..updatecart(editPro),
      ),
      ChangeNotifierProvider<SaleProvider>.value(value: SaleProvider()),
    ];
