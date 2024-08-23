import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DriverAttandace extends StatefulWidget {
  const DriverAttandace({ Key? key }) : super(key: key);

  @override
  _DriverAttandaceState createState() => _DriverAttandaceState();
}

class _DriverAttandaceState extends State<DriverAttandace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
               title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "My Drivers",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)))),
      ),
    body: Column(),
    );
  }
}