import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_buyer_app/config/constants/AppConstants.dart';
import 'package:shopping_buyer_app/controller/cartController.dart';
import 'package:shopping_buyer_app/modules/models/cart.dart';
import 'package:shopping_buyer_app/modules/screens/CartTotal.dart';
import 'package:shopping_buyer_app/modules/widgets/CartProductsCard.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController controller = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void initState() {
    print("jsdjibhivbhibvj");
  }

  read() {
    print("jsdjibhivbhibvj");

    print("jsdjibhivbhibvj");
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot = firestore
        .collection(Collections.CART + "/123asdwqdasdasd/orderlist")
        .snapshots(); //read all the products
    return querySnapshot;
    // List<QueryDocumentSnapshot> list = querySnapshot.docs;
    // List<Cart> cart =
    //     list.map((QueryDocumentSnapshot doc) => Cart.fromJSON(doc)).toList();
    // final Map <String, dynamic> doc = querySnapshot.docs[0];
    // print(querySnapshot.docs[0].data());
    // return cart;
  }

  @override
  Widget build(BuildContext context) {
    read();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SizedBox(
                  height: 500,
                  child: StreamBuilder(
                      stream: read(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("error occured");
                        } else {
                          print("dcsdcdccds");
                          print(snapshot);
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.products.length,
                              // itemCount: snapshot.data,

                              itemBuilder: (BuildContext context, int index) {
                                return CartProductCard(
                                  controller: controller,
                                  product:
                                      controller.products.keys.toList()[index],
                                  quantity: controller.products.values
                                      .toList()[index],
                                  index: index,
                                );
                              });
                        }
                      }),
                ),
              ),
              //  Container(

              //    height: 60,
              //    padding: EdgeInsets.all(10),
              //    child: CartTotal(),
              //  )

              // controller.total==null?
              // Text('Total', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${controller.total}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
