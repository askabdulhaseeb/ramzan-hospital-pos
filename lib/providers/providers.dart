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
      ChangeNotifierProxyProvider<EditItemProvider, ItemFormulaProvider>(
        create: (_) => ItemFormulaProvider(),
        update: (_, EditItemProvider editPro, ItemFormulaProvider? formulaPro) =>
            formulaPro!..updatevalue(editPro),
      ),
      ChangeNotifierProxyProvider<EditItemProvider, ItemManufacturerProvider>(
        create: (_) => ItemManufacturerProvider(),
        update: (_, EditItemProvider editPro, ItemManufacturerProvider? value) =>
            value!..updatevalue(editPro),
      ),
      ChangeNotifierProxyProvider<EditItemProvider, ItemSupplierProvider>(
        create: (_) => ItemSupplierProvider(),
        update: (_, EditItemProvider editPro, ItemSupplierProvider? value) =>
            value!..updatevalue(editPro),
      ),
      ChangeNotifierProvider<SaleProvider>.value(value: SaleProvider()),
    ];
