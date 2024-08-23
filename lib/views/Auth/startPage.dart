import 'package:fleetuser/views/Auth/loginScreen.dart';
import 'package:fleetuser/views/Auth/signUpScreen.dart';
import 'package:fleetuser/views/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}



 






class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/backImage.jpg'))),
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: SizedBox(
                      height: 56,
                      child: RichText(
                          text: TextSpan(
                              text: 'Paras travels',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 45,
                                      fontStyle: FontStyle.italic)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              "Efficiency in motion, control at your fingertips, fleet mastery.",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal))))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: Container(
                  //         width: Get.width * 0.25,
                  //         height: 2,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     RichText(
                  //         text: TextSpan(
                  //             text: 'WellCome',
                  //             style: GoogleFonts.poppins(
                  //                 textStyle: TextStyle(
                  //                     color: Color.fromARGB(255,253, 167, 32),
                  //                     fontWeight: FontWeight.w500,
                  //                     fontSize: 25,
                  //                     fontStyle: FontStyle.normal)))),
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: Container(
                  //         width: Get.width * 0.25,
                  //         height: 2,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 50,
                    child: ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    // You can replace Colors.blue with your desired color
  ),
  onPressed: () async {
    // Debug print statement
    print('Button pressed');

    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the auth token
    var loginToken = prefs.getString('api_token');
    
    // Debug print statement
    print('Retrieved token: $loginToken');

    // Navigate based on token presence
    if (loginToken != null && loginToken.isNotEmpty) {
      // Token is present, navigate to HomePage
      print('Navigating to HomePage');
      Get.offAll(() => HomePage()); // Clear navigation stack
    } else {
      // Token is absent or empty, navigate to LoginScreen
      print('Navigating to LoginScreen');
      Get.offAll(() => LoginScreen()); // Clear navigation stack
    }
  },
  child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: "Sign in",
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontStyle: FontStyle.normal
        )
      )
    )
  ),
)


                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   width: Get.width,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //       style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.white),
                  //         // You can replace Colors.blue with your desired color
                  //       ),
                  //       onPressed: () {
                  //         Get.to(() => SignUpScreen());
                  //       },
                  //       child: RichText(
                  //           textAlign: TextAlign.center,
                  //           text: TextSpan(
                  //               text: "Sign up",
                  //               style: GoogleFonts.poppins(
                  //                   textStyle: TextStyle(
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.w500,
                  //                       fontSize: 16,
                  //                       fontStyle: FontStyle.normal))))),
                  // ),
                  SizedBox(
                    height: 40,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
