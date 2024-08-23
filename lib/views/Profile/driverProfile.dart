import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Superwiser/Mydrivers/mydrivers.dart';




class DriverProfile extends StatefulWidget {
  final Driver driver;

  const DriverProfile({Key? key, required this.driver}) : super(key: key);

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController arrivalTime = TextEditingController();
  bool checkvalue = false;
  List<String> type = ['Very Bad', 'Bad', 'Good', 'Excellent'];
  String ButtonIndex = "";
  TimeOfDay selectedTime = TimeOfDay.now();
  double vehicleCleanlinessRating = 3.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        arrivalTime.text = picked.format(context);
      });
    }
  }

  Widget DriverInfo() {
    return Container(
      height: Get.height * 0.7,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
      padding: EdgeInsets.all(Get.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Arrival Time",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: Get.textScaleFactor * 16,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            SizedBox(
              height: Get.height * 0.06,
              child: TextFormField(
                controller: arrivalTime,
                enabled: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$')),
                ],
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.schedule),
                  border: OutlineInputBorder(),
                  hintText: 'HH:MM',
                ),
                keyboardType: TextInputType.datetime,
                onTap: () => _selectTime(context),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "Vehicle Cleanliness",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: Get.textScaleFactor * 16,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            RatingBar.builder(
              initialRating: vehicleCleanlinessRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: Get.width * 0.06,
              itemPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.green),
              onRatingUpdate: (rating) {
                setState(() {
                  vehicleCleanlinessRating = rating;
                });
              },
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Is Driver in Uniform?",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 16,
                    ),
                  ),
                ),
                Checkbox(
                  value: checkvalue,
                  onChanged: (value) {
                    setState(() {
                      checkvalue = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Divider(color: Colors.black54),
            Text(
              "Vehicle Condition",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: Get.textScaleFactor * 16,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: type.sublist(0, (type.length + 1) ~/ 2).map((e) => buildCheckbox(e)).toList(),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: type.sublist((type.length + 1) ~/ 2).map((e) => buildCheckbox(e)).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget truckInfo() {
    return Container(
      height: Get.height * 0.5,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
      padding: EdgeInsets.all(Get.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customListtile('Name', widget.driver.name, 0, false),
            customListtile('Email', widget.driver.email, 0, false),
            customListtile('Phone', widget.driver.phoneNumber, 0, false),
            customListtile('Address',widget.driver.address, 0, false),
          ],
        ),
      ),
    );
  }

  Widget customListtile(String title, String subtitle, [int? num, bool show = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
      child: Container(
        padding: EdgeInsets.only(bottom: Get.height * 0.01),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 16,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (show)
              Container(
                height: Get.width * 0.08,
                width: Get.width * 0.08,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 0, 174, 243),
                ),
                child: Center(
                  child: Text(
                    "$num",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox(String label) {
    return CheckboxListTile(
      title: Text(
        label,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: Get.textScaleFactor * 14,
          ),
        ),
      ),
      value: ButtonIndex == label,
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            ButtonIndex = label;
          } else {
            ButtonIndex = "";
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
        title: Text(
          "Driver",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: Get.textScaleFactor * 20,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: Get.width * 0.4,
                        width: Get.width * 0.4,
                        child: Image.network(
                          'https://img.freepik.com/free-photo/male-bus-driver-posing-portrait_23-2151582443.jpg?t=st=1722251133~exp=1722254733~hmac=3007cb976f48a1c582d0619df93d2676022bb655a0d7e5bb70573c03f40571ff&w=360',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Driver details",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.textScaleFactor * 20,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Color.fromARGB(255, 0, 174, 243),
                        indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                        labelStyle: GoogleFonts.poppins(fontSize: Get.textScaleFactor * 18),
                        tabs: [
                          Tab(text: 'Driver info'),
                          Tab(text: 'Driver Attendance'),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    SizedBox(
                      height: Get.height * 0.6,
                      child: TabBarView(
                        controller: _tabController,
                        children: [truckInfo(), DriverInfo()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
        child: SizedBox(
          height: Get.height * 0.07,
          width: Get.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 0, 174, 243),
            ),
            onPressed: () {
              // Validation checks
              if (arrivalTime.text.isEmpty) {
                Get.snackbar(
                  'Validation Error',
                  'Please select an arrival time before proceeding.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Color.fromARGB(60, 255, 247, 247),
                  colorText: Color.fromARGB(255, 0, 0, 0),
                );
                return;
              }

              if (vehicleCleanlinessRating == 0) {
                Get.snackbar(
                  'Validation Error',
                  'Please rate the vehicle cleanliness before proceeding.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Color.fromARGB(60, 255, 247, 247),
                  colorText: Color.fromARGB(255, 0, 0, 0),
                );
                return;
              }

              if (ButtonIndex.isEmpty) {
                Get.snackbar(
                  'Validation Error',
                  'Please select a vehicle condition before proceeding.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Color.fromARGB(60, 255, 247, 247),
                  colorText: Color.fromARGB(255, 0, 0, 0),
                );
                return;
              }

          

              // Navigate to the next screen if validation passes
              Get.to(
                () => MyDrivers(),
                transition: Transition.leftToRight,
                duration: Duration(milliseconds: 500),
              );
            },
            child: Text(
              "Attendance",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Get.textScaleFactor * 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
