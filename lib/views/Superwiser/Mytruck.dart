import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/AuthController/auth_controller.dart';

import '../Profile/busprofile.dart';

class Driver {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String userType;
  final String? groupId;
  final Map<String, dynamic> metaData;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleColor;  // Added this line
  final String routeName;
  final String licensePlate;
  final String engineType;
  final String year;

  Driver({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    this.groupId,
    required this.metaData,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleColor,  // Added this line
    required this.routeName,
    required this.licensePlate,
    required this.engineType,
    required this.year,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] ?? {};
    final vehicle = json['vehicle'] ?? {};
    final route = json['route'] ?? {};

    return Driver(
      id: driver['id'] ?? 0,
      userId: driver['user_id'] ?? 0,
      name: driver['name'] ?? '',
      email: driver['email'] ?? '',
      userType: driver['user_type'] ?? '',
      groupId: driver['group_id'],
      metaData: driver['meta_data'] ?? {},
      vehicleMake: vehicle['make_name'] ?? '',
      vehicleModel: vehicle['model_name'] ?? '',
      vehicleColor: vehicle['color_name'] ?? '',  // Added this line
      routeName: route['name'] ?? '',
      licensePlate: vehicle['license_plate'] ?? '',
      engineType: vehicle['engine_type'] ?? '',
      year: vehicle['year'] ?? '',
    );
  }
}
class Mytruck extends StatefulWidget {
  const Mytruck({Key? key}) : super(key: key);

  @override
  _MytruckState createState() => _MytruckState();
}

class _MytruckState extends State<Mytruck> {
  List<Driver> drivers = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

Future<void> fetchDrivers() async {
  setState(() {
    isLoading = true;
    hasError = false;
  });

  try {
    // Retrieve the token from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('api_token'); // Use your key for the token

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Auth token is missing. Please log in again.');
    }

    print('Auth Token: $authToken');

    final response = await http.get(
      Uri.parse('https://kriscenttechnohub.in/demo/paras-travels/api/assigned-task'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'accept': 'application/json',
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final List<dynamic> resultData = jsonResponse['result'];
        setState(() {
          drivers = resultData.map((data) => Driver.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('API returned false status: ${jsonResponse['status']}');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized. Please check your authentication token.');
    } else {
      throw Exception('Failed to load drivers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error in fetchDrivers: $e');
    setState(() {
      isLoading = false;
      hasError = true;
      errorMessage = 'Failed to load drivers. ${e.toString()}';
    });
  }
}

  Widget busProfile(Driver driver) {
    return Container(
      height: 100,
      width: Get.width,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: double.infinity,
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fit: BoxFit.cover,
                  'https://img.freepik.com/premium-photo/bus-parked-road_69593-7793.jpg?w=900',
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${driver.vehicleMake} ${driver.vehicleModel}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                customListtile('Plate', driver.licensePlate, 0, false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Route",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      driver.routeName,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customListtile(String title, String subtitle, int? num, bool show) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          if (show)
            Container(
              height: 30,
              width: 30,
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
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
        title: Text(
          "My Bus",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: drivers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => Busprofile(driver: drivers[index]),
                          transition: Transition.leftToRight,
                        );
                      },
                      child: busProfile(drivers[index]),
                    );
                  },
                ),
    );
  }
}
