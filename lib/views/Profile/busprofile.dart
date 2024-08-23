import 'package:fleetuser/views/Superwiser/Mytruck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Busprofile extends StatelessWidget {
  final Driver driver;

  const Busprofile({Key? key, required this.driver}) : super(key: key);

  void _showRepairRequestDialog(BuildContext context) {
    final TextEditingController _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Repair Request',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: Get.textScaleFactor * 18,
              ),
            ),
          ),
          content: TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter description of repair needed',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: Get.textScaleFactor * 16,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final description = _descriptionController.text;
                if (description.isNotEmpty) {
                  // Process the repair request
                  // For example, send the request to the server or perform other actions

                  Navigator.of(context).pop(); // Close the dialog
                  Get.snackbar(
                    'Repair Request Sent',
                    'Your repair request has been submitted successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a description for the repair request.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 174, 243),
                    fontWeight: FontWeight.w500,
                    fontSize: Get.textScaleFactor * 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoContainer(List<Widget> children) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _customListTile(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: Get.textScaleFactor * 16,
              ),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 3,
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: Get.textScaleFactor * 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _repairRequestButton(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      child: ElevatedButton(
        onPressed: () => _showRepairRequestDialog(context),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 0, 174, 243),
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Send Repair Request',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Get.textScaleFactor * 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
        title: Text(
          "My Bus",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Get.textScaleFactor * 22,
          ),
        ),
        elevation: 4,
      ),
      body: DefaultTabController(
        length: 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: Get.height * 0.02),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://img.freepik.com/premium-photo/bus-parked-road_69593-7793.jpg?w=900',
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: Get.height * 0.015),
                Text(
                  "Bus details",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.textScaleFactor * 22,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color.fromARGB(255, 0, 174, 243),
                  labelStyle: GoogleFonts.poppins(fontSize: Get.textScaleFactor * 16, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(text: 'Bus info'),
                    Tab(text: 'About Driver'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildInfoContainer([
                        _customListTile('Model', '${driver.vehicleMake} ${driver.vehicleModel}'),
                        _customListTile('Colour', '${driver.vehicleColor}'),
                        _customListTile('License Plate', driver.licensePlate),
                        _customListTile('Engine Type', driver.engineType),
                        _customListTile('Year', driver.year),
                      ]),
                      _buildInfoContainer([
                        _customListTile('Driver Name', driver.name),
                        _customListTile('Email', driver.email),
                        _customListTile('Phone', "15456323656"),
                        _customListTile('Route', driver.routeName),
                      ]),
                    ],
                  ),
                ),
                _repairRequestButton(context),
              ],
            );
          },
        ),
      ),
    );
  }
}
