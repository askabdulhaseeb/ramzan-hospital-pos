import 'package:flutter/cupertino.dart';

import '../models/item/cart_item.dart';
import '../models/item/item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItem => _cartItems;

  void addtocart(Item value, int quantity) async {
    CartItem temp = CartItem(
      discount: 0,
      itemID: value.id,
      price: value.salePrice * quantity,
      salemanID: 'dev markaz',
      quantity: quantity,
    );
    _cartItems.add(temp);
    notifyListeners();
  }
}
