import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helperWidget/textFormFields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 150,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Sign Up",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 174, 243),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontStyle: FontStyle.normal)))),
            SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Create a new  account",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            fontStyle: FontStyle.normal)))),
            // SizedBox(
            //   height: 18,
            // ),
            SizedBox(
              height: 18,
            ),
            CustomTextField(
              controller: _textController,
              hintText: 'Name',
              suffixIcon: Icons.person,
            ),
            SizedBox(
              height: 18,
            ),
            CustomTextField(
              controller: _textController,
              hintText: 'Enter you email or Mobile number',
              suffixIcon: Icons.person,
            ),

            SizedBox(
              height: 18,
            ),
            CustomTextField(
              controller: _textController,
              hintText: 'Password',
              suffixIcon: Icons.lock,
            ),
            SizedBox(
              height: 18,
            ),
            CustomTextField(
              controller: _textController,
              hintText: 'Confirm Password',
              suffixIcon: Icons.lock,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 0, 174, 243))),
                  onPressed: () {},
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Sign up",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal))))),
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Allready have an account?\n Sign in now!",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontStyle: FontStyle.normal))))
          ],
        ),
      ),
    );
  }
}
