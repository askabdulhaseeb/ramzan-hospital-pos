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

  void onDiscountUpdate(String str, int index) {
   // final int index = _indexOfSelectedIndex(value.id);
    double a = double.parse(str);
    _cartItems[index].discount = a;
    notifyListeners();
  }

  int _indexOfSelectedIndex(String item1) {
    return _items.indexWhere((Item element) => element.id == item1);
  }

   List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItem => _cartItems;

   List<Item> _items = <Item>[];
  List<Item> get item => _items;
}
