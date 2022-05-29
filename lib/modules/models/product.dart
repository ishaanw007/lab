import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  late String name;
  late String desc;
  late double price;
  late double qty;
  late String url;
  Product() {}
  Product.takeProduct(
      {this.id = "",
      required this.name,
      required this.desc,
      required this.price,
      required this.qty,
      required this.url});
  Product.fromJSON(QueryDocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'];
    url = doc['url'];
    desc = doc['desc'];
    price = double.parse(doc['price'].toString());
    qty = doc['qty'];
  }
  Product.fromMap(dynamic doc,this.id) {
    name = doc['name'];
    url = doc['url'];
    desc = doc['desc'];
    price = double.parse(doc['price'].toString());
    qty = doc['qty'];
  }
  // @override
  String toString() {
    return "id: $id name: $name , Description:$desc ,Price:$price ,Quantity:$qty";
  }

  Map<String, dynamic> toJSON() {
    return {'name': name, "desc": desc, "price": price, "qty": qty, "url": url};
  }
}
