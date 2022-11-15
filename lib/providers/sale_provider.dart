import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/item/cart_item.dart';
import '../models/item/item.dart';

class SaleProvider extends ChangeNotifier {
  AppUser? saleman;
  // customer
  TextEditingController defaultQuantity = TextEditingController(text: '1');
  List<CartItem> _items = <CartItem>[];
}
