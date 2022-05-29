// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_buyer_app/controller/cartController.dart';
import 'package:shopping_buyer_app/modules/models/cart.dart';
import 'package:shopping_buyer_app/modules/models/product_description.dart';
import '/modules/repository/product_repo.dart';

import '../models/product.dart';

class ViewProduct extends StatelessWidget {
  final cartController = Get.put(CartController());
  ProductRepository repo = ProductRepository();
  late Product product;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          child: StreamBuilder(
              stream: repo.readRealTime(),
              builder:
                  ((BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                ConnectionState state = snapshot.connectionState;
                if (state == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  print("Error is ...");
                  print(snapshot.error);
                  return Center(
                    child: Text('Some error in retrieving products'),
                  );
                } else {
                  return Container(
                    height: 450,
                    child: ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        var doc = snapshot.data!.docs[index].data();
                        product =
                            Product.fromMap(doc, snapshot.data!.docs[index].id);
                        return ListTile(
                            leading: Container(
                                width: deviceSize.width / 5.2,
                                child: Image.network(product.url)),
                            title: Text(product.name),
                            // subtitle: Text(snapshot.data![index].desc),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.desc),
                                Text("Quantity : ${product.qty}")
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize
                                  .min, //without this it takes main axis size as size which overflow and gives error
                              children: [
                                IconButton(
                                    onPressed: () {
                                      product = Product.fromMap(
                                          doc, snapshot.data!.docs[index].id);
                                      addProductToCart(
                                          snapshot.data!.docs[index].id,
                                          product.price,
                                          product.url,
                                          product.name,
                                          "123asdwqdasdasd");
                                      cartController.addProduct(Product.fromMap(
                                          doc, snapshot.data!.docs[index].id));
                                    },
                                    icon: Icon(Icons.add)),
                                // IconButton(
                                //     onPressed: () {
                                //       //delete the product
                                //     },
                                //     icon: Icon(
                                //       Icons.delete,
                                //       color: Colors.red,
                                //     ))
                              ],
                            ));
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                }
              }))),
    );
  }

  void addProductToCart(
      String id, double price, String url, String name, String s) {
    getPreviousCount(id, price, url, name, s);
  }

  // void getPreviousCount(String id, String s) async {
  void getPreviousCount(
      String id, double price, String url, String name, String s) async {
    try {
      DocumentReference querySnapshot =
          await firestore.collection("cart").doc(s)
      .collection('orderlist')
      .doc(id);

      querySnapshot.get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          int valueToUpdate = int.parse(doc.get('quantity').toString()) + 1;
          lol(id, valueToUpdate, price.toString(), url, name, s);
        } else {
          lol(id, 1, price.toString(), url, name, s);
        }
      });
    } catch (e) {
      // lol(id, 1, s);
    }
  }

  void lol(String id, int valueToTupdate, String price, String url, String name,
      String s) {
    try {
      Future<void> red = firestore.collection('cart').doc(s).set({"userid": s});
      // print("eskhejwghgesfggesijsebfhjfaeyfewdhjbewFJKBfewigfkjfejk");
      // print(price);
      print(ProductDescription(id, valueToTupdate, price, url, name).toJSON());
      Future<void> red2 = firestore
          .collection('cart')
          .doc(s)
          .collection('orderlist')
          .doc(id)
          .set(ProductDescription(id, valueToTupdate, price, url, name)
              .toJSON());
      print(red);
    } catch (e) {
      print(e);
    }
  }
  // Widget build(BuildContext context) {
  //   Size deviceSize = MediaQuery.of(context).size;
  //   ProductRepository repo = ProductRepository();
  //   return Container(
  //     child: FutureBuilder(
  //       future: repo.read(), //Firebase read operation, which give future
  //       builder: (BuildContext ctx, AsyncSnapshot<List<Product>> snapshot) {
  //         ConnectionState state = snapshot.connectionState;
  //         if (state == ConnectionState.waiting) {
  //           //loading
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else if (snapshot.hasError) {
  //           print("Error is ...");
  //           print(snapshot.error);
  //           return Center(
  //             child: Text('Some error in retrieving products'),
  //           );
  //         } else {
  //           //it has data
  //           return ListView.builder(
  //             itemBuilder: (BuildContext ctx, int index) {
  //               return ListTile(
  //                   leading: Container(
  //                       width: deviceSize.width / 5.2,
  //                       child: Image.network(snapshot.data![index].url)),
  //                   title: Text(snapshot.data![index].name),
  //                   // subtitle: Text(snapshot.data![index].desc),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(snapshot.data![index].desc),
  //                       Text("Quantity : ${snapshot.data![index].qty}")
  //                     ],
  //                   ),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,//without this it takes main axis size as size which overflow and gives error
  //                     children: [
  //                       IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(
  //                             Icons.delete,
  //                             color: Colors.red,
  //                           ))
  //                     ],
  //                   )
  //                   );
  //             },
  //             itemCount: snapshot.data!.length,
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
}
