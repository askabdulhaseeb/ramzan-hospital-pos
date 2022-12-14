import 'package:flutter/cupertino.dart';

import '../models/item/cart_item.dart';
import '../models/item/item.dart';

class CartProvider extends ChangeNotifier {
  void addtocart(Item value, int quantity) async {
    final int index = _indexOfSelectedIndex(value.id);

    if (index >= 0) {
      _cartItems[index].quantity += quantity;
      _cartItems[index].price = 0;
      _cartItems[index].price = value.salePrice * _cartItems[index].quantity;
    } else {
      CartItem temp = CartItem(
        discount: 0,
        itemID: value.id,
        price: value.salePrice * quantity,
        salemanID: 'dev markaz',
        quantity: quantity,
      );
      _items.add(value);
      _cartItems.add(temp);
    }
    total();
  }

  void onDiscountUpdate(String str, int index) {
    // final int index = _indexOfSelectedIndex(value.id);
    double a = double.parse(str);
    _cartItems[index].discount = a;
    total();
  }

  void customerDiscountUpdate(String str) {
    double a = double.parse(str);
    customerDiscount = a;
    notifyListeners();
  }

  void adjustmentUpdate(String str) {
    double a = double.parse(str);
    adjustment = a;
    notifyListeners();
  }

  double afterDiscountTestPrice(CartItem value) {
    return value.price - value.discount;
  }

  void total() {
    totalNetPrice = 0;
    totalDiscount = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalNetPrice += _cartItems[i].price;
      totalDiscount += _cartItems[i].discount;
    }
    notifyListeners();
  }

  double grossTotal() {
    return totalNetPrice - totalDiscount - customerDiscount;
  }

  double netTotal() {
    return totalNetPrice - totalDiscount - customerDiscount - adjustment;
  }

  int _indexOfSelectedIndex(String item1) {
    return _items.indexWhere((Item element) => element.id == item1);
  }

  delete(String id) {
    _cartItems.removeWhere((cartItem) => cartItem.itemID == id);
    _items.removeWhere((item) => item.id == id);
    total();
  }

  emptyCart() {
    _cartItems.clear();
    _items.clear();
    totalNetPrice = 0;
    totalDiscount = 0;
    customerDiscount = 0;
    adjustment = 0;
  }

  List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItem => _cartItems;

  List<Item> _items = <Item>[];
  List<Item> get item => _items;
  double totalNetPrice = 0;
  double totalDiscount = 0;
  double customerDiscount = 0;
  double adjustment = 0;
}
