

class Item {
  Item({
    required this.id,
    required this.name,
    required this.code,
    required this.line,
    required this.category,
    required this.subCategory,
    required this.formula,
    required this.manufacturer,
    required this.supplier,
    this.quantity = 0,
    this.averagePrice = 0,
    this.salePrice = 0,
    this.discount = 0,
  });

  final String id;
  final String name;
  final String code;
  final String line;
  final String category;
  final String subCategory;
  final String formula;
  final String manufacturer;
  final String supplier;
   int quantity;
  final double averagePrice;
  final double salePrice;
  final double discount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'line': line,
      'category': category,
      'sub_category': subCategory,
      'formula': formula,
      'manufacturer': manufacturer,
      'supplier': supplier,
      'quantity': quantity,
      'average_price': averagePrice,
      'sale_price': salePrice,
      'discount': discount,
    };
  }
  updateQuantity(){
    return  <String, dynamic>{
      'quantity': quantity,
    };
  }

  // ignore: sort_constructors_first
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      line: map['line'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['sub_category'] ?? '',
      formula: map['formula'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      supplier: map['supplier'] ?? '',
      quantity: map['quantity'] ?? 0,
      averagePrice: map['average_price'] ?? 0,
      salePrice: map['sale_price'] ?? 0,
      discount: map['discount'] ?? 0,
    );
  }
}
