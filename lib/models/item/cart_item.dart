import 'package:flutter/src/widgets/framework.dart';

class CartItem {

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      itemID: map['item_id'] as String,
      salemanID: map['saleman_id'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      discount: map['discount'] as double,
    );
  }
  CartItem({
    required this.itemID,
    required this.salemanID,
    required this.price,
    required this.quantity,
    required this.discount,
  });

  final String itemID;
  final String salemanID;
   double price;
   int quantity;
  double discount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_id': itemID,
      'saleman_id': salemanID,
      'price': price,
      'quantity': quantity,
      'discount': discount,
    };
  }
}
