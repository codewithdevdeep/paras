import 'dart:math';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

class TaskHistory extends StatefulWidget {
  const TaskHistory({Key? key}) : super(key: key);

  @override
  _TaskHistoryState createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  late DateTime _selectedDate;
  int num = 3;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  Widget TaskWidget() {
    return Container(
      height: 260,
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
              'Location', '930 Stoney creek , grayson, Canada', 2, false),
          customListtile('Status', 'completed', 2, false)
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
                text: "Task History",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarTimeline(
            showYears: true,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
            onDateSelected: (date) => {
              print(date),
              setState(() {
                Random random = Random();

                num = random.nextInt(3) + 1;
                _selectedDate = date;
              })
            },
            leftMargin: 20,
            monthColor: Color.fromARGB(255, 0, 174, 243),
            dayColor: Colors.teal[200],
            dayNameColor: const Color(0xFF333A47),
            activeDayColor: Color.fromARGB(255, 0, 174, 243),
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: const Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en',
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: num,
            itemBuilder: (context, index) {
              return TaskWidget();
            },
          ))
        ],
      ),
    );
  }
}
