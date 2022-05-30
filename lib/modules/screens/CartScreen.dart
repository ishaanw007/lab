// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopping_buyer_app/config/constants/AppConstants.dart';
// import 'package:shopping_buyer_app/controller/cartController.dart';
// import 'package:shopping_buyer_app/modules/models/cart.dart';
// import 'package:shopping_buyer_app/modules/screens/CartTotal.dart';
// import 'package:shopping_buyer_app/modules/widgets/CartProductsCard.dart';

// class CartScreen extends StatefulWidget {

//   CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartController controller = Get.find();

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   void initState() {
    
//     print("jsdjibhivbhibvj");
//   }

  

//   read() {
//     print("jsdjibhivbhibvj");
    
//     print("jsdjibhivbhibvj");
//       Future<QuerySnapshot> querySnapshot =
//            firestore.collection(Collections.CART+"/123asdwqdasdasd/orderlist").get(); //read all the products
//       // List<QueryDocumentSnapshot> list = querySnapshot.docs;
//       // List<Cart> cart =
//       //     list.map((QueryDocumentSnapshot doc) => Cart.fromJSON(doc)).toList();
//       // final Map <String, dynamic> doc = querySnapshot.docs[0];
//       querySnapshot.then((value) => print(value.docs[0].data()));
//       // print(querySnapshot.docs[0].data());
//       // return cart;
     
      
//     }

  

//   @override
//   Widget build(BuildContext context) {
//     read();
    
//     return Obx(
//       () => Scaffold(
//         appBar: AppBar(
//           title: Text("Your Cart"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: SizedBox(
//                   height: 500,
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: controller.products.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return CartProductCard(
//                           controller: controller,
//                           product: controller.products.keys.toList()[index],
//                           quantity: controller.products.values.toList()[index],
//                           index: index,
//                         );
//                       }),
//                 ),
//               ),
//               //  Container(

//               //    height: 60,
//               //    padding: EdgeInsets.all(10),
//               //    child: CartTotal(),
//               //  )

//               // controller.total==null?
//               // Text('Total', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       'Total',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       "${controller.total}",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_buyer_app/config/constants/AppConstants.dart';
// import 'package:shopping_seller_app/config/constants/AppConstants.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({Key? key}) : super(key: key);

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  read(Function getCartList, Function getError) {
    // print("object");
    Future<QuerySnapshot> snapshot =
        firestore.collection(Collections.CART + "/123asdwqdasdasd/orderlist").get();
    snapshot
        .then((value) => getCartList(value))
        .catchError((onError) => getError(onError));
  }

  List<dynamic> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    read(getCartList, getError);
  }

  getCartList(QuerySnapshot snapshot) {
    list = snapshot.docs;
    setState(() {});
  }

  getError(dynamic err) {
    print("error is $err");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: list.length == 0
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    var doc = list[index].data();
                    print(doc);
                    return ListTile(
                      subtitle: Text(doc['quantity'].toString()),
                      title: Text(doc["name"]),
                        leading: Container(
                      height: 100,
                      width: 100,
                      child: Image.network(doc['url'])
                      
                    ));
                  })),
        ));
  }
}
