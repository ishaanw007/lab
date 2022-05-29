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

  

  read() async {
    print("jsdjibhivbhibvj");
    try {
    print("jsdjibhivbhibvj");
      QuerySnapshot querySnapshot =
          await firestore.collection(Collections.CART).get(); //read all the products
      // List<QueryDocumentSnapshot> list = querySnapshot.docs;
      // List<Cart> cart =
      //     list.map((QueryDocumentSnapshot doc) => Cart.fromJSON(doc)).toList();
      print(querySnapshot.docs[0]["orderlist"].data());
      // return cart;
    } catch (err) {
      print(err);
    }
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartProductCard(
                          controller: controller,
                          product: controller.products.keys.toList()[index],
                          quantity: controller.products.values.toList()[index],
                          index: index,
                        );
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
