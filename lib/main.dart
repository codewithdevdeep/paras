import 'package:fleetuser/views/Attandance/driverAttandace.dart';
import 'package:fleetuser/views/Auth/startPage.dart';
import 'package:fleetuser/views/Profile/driverProfile.dart';
import 'package:fleetuser/views/Superwiser/Mydrivers/mydrivers.dart';
import 'package:fleetuser/views/Driver/deatailpage/deatailpage.dart';
import 'package:fleetuser/views/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/AuthController/auth_controller.dart';
import 'Controller/AuthController/loginController.dart';
import 'Controller/ThemeController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  Themes _themes = Themes();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:StartPage()
    );
  }
}
