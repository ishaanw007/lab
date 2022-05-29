import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_buyer_app/modules/models/product.dart';
import 'package:shopping_buyer_app/modules/models/product_description.dart';

class Cart {
  late String userId;
  late List<Map<String,dynamic>> products;
  // late String id;
  // late String name;
  // late String desc;
  // late double price;
  // late double qty;
  // late String url;
   Cart() {}
  Cart.takeProduct(
      {
      required this.userId,
      // required this.id,
      required this.products,
      // required this.name,
      // required this.desc,
      // required this.price,
      // required this.qty,
      // required this.url
      }
      );
  Cart.fromJSON(QueryDocumentSnapshot doc) {
    //  id = doc.id;
    userId = doc['userId'];
    // name = doc['name'];
    products= doc['products'];
    // url = doc['url'];
    // desc = doc['desc'];
    // price = double.parse(doc['price'].toString());
    // qty = doc['qty'];
  }
  Cart.fromMap(dynamic doc) {
      userId = doc['userId'];
    products= doc['products'];
    // userId = doc['userId'];
    // name = doc['name'];
    // url = doc['url'];
    // desc = doc['desc'];
    // price = double.parse(doc['price'].toString());
    // qty = doc['qty'];
  }
  @override
  // String toString() {
  //   return "Product id is $id Product name is $name , Product Description is $desc , Product Price is $price , Product Quantity is $qty";
  // }

  Map<String, dynamic> toJSON() {
    return {
      'userId': userId,
       'products':products
      // 'name': name,
      // "desc": desc,
      // "price": price,
      // "qty": qty,
      // "url": url
    };
  }
}
