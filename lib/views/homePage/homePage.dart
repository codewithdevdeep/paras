
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fleetuser/Controller/AuthController/loginController.dart';
import 'package:fleetuser/views/Superwiser/Mytruck.dart';
import 'package:fleetuser/views/homePage/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.put(LoginController());

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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('api_token');

      if (authToken == null || authToken.isEmpty) {
        throw Exception('Auth token is missing. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('https://kriscenttechnohub.in/demo/paras-travels/api/assigned-task'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          final List<dynamic> resultData = jsonResponse['result'];
          setState(() {
            drivers = resultData.map((data) {
              return Driver.fromJson(data);
            }).toList();
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
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Failed to load drivers. ${e.toString()}';
      });
    }
  }

  Widget TaskWidget(Driver driver) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/purple-man-with-blue-hair_24877-82003.jpg?w=740&t=st=1721996508~exp=1721997108~hmac=1120e3983308a4167f9b9b67a7c224f62758b54aed3b2fef0a658cf47176b55c',
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driver.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                driver.vehicleMake,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      InfoRow(icon: Icons.phone, text: driver.phoneNumber),
                      InfoRow(icon: Icons.access_time, text: "20 Mar, 02:30 PM"),
                      InfoRow(icon: Icons.route, text: driver.routeName),
                      InfoRow(icon: Icons.pin_drop, text: driver.distance.toString()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1664302152991-d013ff125f3f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget InfoRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return false; // Prevent back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, color: Colors.white),
              );
            },
          ),
          backgroundColor: Color.fromARGB(255, 0, 174, 243),
          title: Text(
            "Today's task",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : hasError
                ? Center(child: Text(errorMessage))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: drivers.length,
                    itemBuilder: (context, index) {
                      return TaskWidget(drivers[index]);
                    },
                  ),
      ),
    );
  }
}

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
  final String address;
  final int distance;

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
    required this.address,
    required this.distance,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    final driver = json['driver'] ?? {};
    final vehicle = json['vehicle'] ?? {};
    final route = json['route'] ?? {};
    final metaData = driver['meta_data'] ?? {};

    return Driver(
      id: driver['id'] ?? 0,
      userId: driver['user_id'] ?? 0,
      name: driver['name'] ?? 'N/A',
      email: driver['email'] ?? 'N/A',
      userType: driver['user_type'] ?? 'N/A',
      groupId: driver['group_id'],
      metaData: metaData,
      vehicleMake: vehicle['make_name'] ?? 'N/A',
      vehicleModel: vehicle['model_name'] ?? 'N/A',
      

      vehicleColor: vehicle['color_name'] ?? '',
      routeName: route['name'] ?? '',
      licensePlate: vehicle['license_plate'] ?? '',
      engineType: vehicle['engine_type'] ?? '',
      year: vehicle['year'] ?? '',
      phoneNumber: metaData['phone'] ?? '',
      address: metaData['address'] ?? '',
      distance: route['distance'] ?? '', 
    );
  }
}
