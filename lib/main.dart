import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_buyer_app/modules/screens/dashboard.dart';

void main(List<String> args)  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: Dashboard(), //once initial route defined no need to mention home
    // initialRoute: RouteConstants.DASHBOARD, //inital or base route
    // routes: getRoutes(), //all routes are loaded here 
  ));
}