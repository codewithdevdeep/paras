
import 'package:fleetuser/views/Profile/driverProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/AuthController/auth_controller.dart';

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
  final String vehicleColor;
  final String routeName;
  final String licensePlate;
  final String engineType;
  final String year;
  final String phoneNumber;
  final String address; // Added this line

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
    required this.vehicleColor,
    required this.routeName,
    required this.licensePlate,
    required this.engineType,
    required this.year,
    required this.phoneNumber,
    required this.address, // Added this line
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] ?? {};
    final vehicle = json['vehicle'] ?? {};
    final route = json['route'] ?? {};
    final metaData = driver['meta_data'] ?? {};

    return Driver(
      id: driver['id'] ?? 0,
      userId: driver['user_id'] ?? 0,
      name: driver['name'] ?? '',
      email: driver['email'] ?? '',
      userType: driver['user_type'] ?? '',
      groupId: driver['group_id'],
      metaData: metaData,
      vehicleMake: vehicle['make_name'] ?? '',
      vehicleModel: vehicle['model_name'] ?? '',
      vehicleColor: vehicle['color_name'] ?? '',
      routeName: route['name'] ?? '',
      licensePlate: vehicle['license_plate'] ?? '',
      engineType: vehicle['engine_type'] ?? '',
      year: vehicle['year'] ?? '',
      phoneNumber: metaData['phone'] ?? '',
      address: metaData['address'] ?? '', // Added this line
    );
  }
}


class MyDrivers extends StatefulWidget {
  const MyDrivers({Key? key}) : super(key: key);

  @override
  _MyDriversState createState() => _MyDriversState();
}

class _MyDriversState extends State<MyDrivers> {
  final AuthController _authController = Get.find<AuthController>();
  List<Driver> drivers = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

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
      final String? authToken = prefs.getString('api_token'); // Use the key for the token

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
            drivers = resultData.map((data) {
              final driver = Driver.fromJson(data);
              if (driver.name == 'Unknown' || driver.routeName == 'Unknown' || driver.vehicleMake == 'Unknown') {
                // Add logic to handle the case where driver, route, or vehicle is not assigned
                print('Driver, route, or vehicle not assigned for one of the records.');
              }
              return driver;
            }).where((driver) => driver.name != 'Unknown').toList();
            isLoading = false;
          });
          if (drivers.isEmpty) {
            setState(() {
              hasError = true;
              errorMessage = 'No valid driver data found.';
            });
          }
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

  void navigateToDriverProfile(Driver driver) {
  Get.to(() => DriverProfile(driver: driver));
}

Widget driverProfileWidget(Driver driver) {
  return GestureDetector(
    onTap: () => navigateToDriverProfile(driver), // Updated to use navigateToDriverProfile
    child: Container(
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
                  'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    'Email: ${driver.email}',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
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
        leading: BackButton(color: Colors.white),
        title: Text(
          "My Drivers",
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchDrivers,
                    child: Text('Try Again'),
                  ),
                ],
              ),
            )
          : drivers.isEmpty
            ? Center(child: Text('No drivers found'))
            : ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return driverProfileWidget(drivers[index]);
                },
              ),
    );
  }
}
