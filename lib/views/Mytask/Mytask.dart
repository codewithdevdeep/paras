import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytask extends StatefulWidget {
  const Mytask({Key? key}) : super(key: key);

  @override
  _MytaskState createState() => _MytaskState();
}

class _MytaskState extends State<Mytask> {
  Widget TaskWidget() {
    return Container(
      height: 250,
      width: Get.width,
      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                            'https://img.icons8.com/bubbles/50/truck.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: "KUP 1598",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal)))),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Scania R125",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal))))
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Calgary(121 km)",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 174, 243),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal)))),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          customListtile('Task', 'Chemical Delivery', 2, true),
          customListtile('Departed', '20 mar, 02.30pm', 2, false),
          customListtile(
              'Location', '930 Stoney creek , grayson, Canada', 2, false)
        ],
      ),
    );
  }

  Widget customListtile(String title, String subtitle, int? num, bool show) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: "$title",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              fontStyle: FontStyle.normal)))),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "$subtitle",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontStyle: FontStyle.normal))))
            ],
          ),
          show
              ? Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color.fromARGB(255, 0, 174, 243)),
                  child: Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "$num",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal)))),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "My Task List",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)))),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/mapimage.jpg'))),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return TaskWidget();
          },
        ),
      ),
    );
  }
}
