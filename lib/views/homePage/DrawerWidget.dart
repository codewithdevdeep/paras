import 'dart:math';

import 'package:fleetuser/Controller/AuthController/loginController.dart';
import 'package:fleetuser/views/Auth/startPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import '../../Controller/AuthController/auth_controller.dart';
import '../../const/transitionConst.dart';
import '../History/TaskHistory.dart';
import '../Mytask/Mytask.dart';
import '../Superwiser/Mydrivers/mydrivers.dart';
import '../Superwiser/Mytruck.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Widget drawerElement(IconData iconData, String name, void Function()? ontab) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 40.0, right: 120.0),
      leading: Icon(
        iconData,
        color: Colors.black,
      ),
      title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: name,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      fontStyle: FontStyle.normal)))),
      onTap: ontab,
    );
  }

  Widget _drawerItem(
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 25,
            ),
            SizedBox(
              width: 15,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 156, 211, 233),
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_pin,
                      size: 60,
                    ),
                  ),
                  Obx(() => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "${loginController.name.value}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal))))),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "+919638527415",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal))))
                ],
              ),
            ),
          ),
          _drawerItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Obx(() => loginController.isDriver.value
              ? _drawerItem(
                  icon: Icons.task,
                  title: 'My Task',
                  onTap: () {
                    Get.to(Mytask(),
                        transition: Transition.leftToRight);
                  },
                )
              : _drawerItem(
                  icon: Icons.bus_alert,
                  title: 'My Bus',
                  onTap: () {
                    Get.to(Mytruck(),
                        transition: Transition.leftToRight);
                  },
                )),
          Obx(() => loginController.isDriver.value
              ? _drawerItem(
                  icon: Icons.history,
                  title: 'My Trip History',
                  onTap: () {
                    Get.to(Mytask(),
                        transition: Transition.leftToRight);
                  },
                )
              : _drawerItem(
                  icon: Icons.drive_eta,
                  title: 'My Drivers',
                  onTap: () {
                    Get.to(MyDrivers(),
                        transition: Transition.leftToRight);
                  },
                )),
       
   _drawerItem(
  icon: Icons.logout,
  title: 'LogOut',
  onTap: () {
    Get.defaultDialog(
      title: 'Do you want to log out?',
      middleText: '',
      textCancel: 'Cancel',
      textConfirm: 'Log Out',
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.back(); // Close the dialog
      },
      onConfirm: () async {
        // Close the dialog
        Get.back();

        // Clear the auth token using AuthController
      // Ensure this method exists in AuthController

        // Remove token from GetStorage or SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('api_token');
        // Optionally remove other keys if needed
        // await prefs.remove('isRecruiter');

        // Print a confirmation message for debugging
        print('User logged out. Token cleared.');

        // Navigate to the login screen
        Get.offAll(() => StartPage()); // or your login page
      },
    );
  },
)


        ],
      ),
    );
  }
}
