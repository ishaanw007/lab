import 'package:get/get.dart';
import 'package:shopping_buyer_app/modules/models/cart.dart';
import 'package:shopping_buyer_app/modules/models/product.dart';

class CartController extends GetxController {
  // Addadict to store the products in the cart.
  var _products = {}.obs;
  var list = [];
  
  // Cart cart=Cart.takeProduct(userId: "ishaan", products: _products);
  // List<Product> products = [];
  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
      // products.add(product);
      // print(products);
    } else {
      _products[product] = 1;
    }
    // printproducts();
    //  print(_products.keys);

    //  print("hello");
    // print(_products.value);
    //  print("hello");
    // print(_products);
    Get.snackbar("product added", "you have added ${product.name}",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  void remove(Product product) {
    if (_products.containsKey(product)) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

//   void printproducts() {
// //             _products.entries.forEach((e) => list.add(_products(e.key, e.value)));
// // print(list);

// list =_products.entries
//       .map((product) => Product(product.key , product.value)).toList();
//     // _products.forEach((k, v) => list.add(products(k, v)));
//     print(list);
//   }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();
  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toString();

  // get productname => _products.entries
  // .map((product) => product.key.name)
  // .toList();
}
