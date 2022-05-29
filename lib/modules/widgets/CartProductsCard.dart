import 'package:flutter/material.dart';
import 'package:shopping_buyer_app/controller/cartController.dart';
import 'package:shopping_buyer_app/modules/models/product.dart';

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  const CartProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(radius: 40, backgroundImage: NetworkImage(product.url)),
          // Te xt()
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text(product.name)),
          IconButton(
              onPressed: () {
                controller.removeProduct(product);
              },
              icon: Icon(Icons.remove_circle)),
          Text('${quantity}'),
          IconButton(
              onPressed: () {
                controller.addProduct(product);
              },
              icon: Icon(Icons.add_circle)),
              IconButton(
              onPressed: () {
                controller.remove(product);
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
