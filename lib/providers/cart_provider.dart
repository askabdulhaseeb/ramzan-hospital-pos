import 'package:flutter/cupertino.dart';

import '../models/item/cart_item.dart';
import '../models/item/item.dart';

class CartProvider extends ChangeNotifier {
  void addtocart(Item value, int quantity) async {
    CartItem temp = CartItem(
      discount: 0,
      itemID: value.id,
      price: value.salePrice * quantity,
      salemanID: 'dev markaz',
      quantity: quantity,
    );
    _items.add(value);
    _cartItems.add(temp);
    notifyListeners();
  }

  final List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItem => _cartItems;

  final List<Item> _items = <Item>[];
  List<Item> get item => _items;
}
