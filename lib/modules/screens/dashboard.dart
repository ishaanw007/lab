import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_buyer_app/modules/screens/CartScreen.dart';
import 'package:shopping_buyer_app/modules/widgets/view_product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      
      body: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10),
                   child: ViewProduct(),//You can try this widget first to confirm firebase integration
                  // child:Text("Your widget") 
                  ),
                  const SizedBox(height:52),

                  ElevatedButton(onPressed: () => Get.to(CartScreen()), child: Text("Go to Cart"))
            ],
          )
              
          ),
    );
  } 
}
