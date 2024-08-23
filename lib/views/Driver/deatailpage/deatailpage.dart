import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fleetuser/views/Driver/deatailpage/fuel_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:timeline_tile/timeline_tile.dart';

import '../../../Controller/AuthController/loginController.dart';

class DeliveryTrackingPage extends StatefulWidget {
  @override
  _DeliveryTrackingPageState createState() => _DeliveryTrackingPageState();
}

class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
  loc.LocationData? _currentLocation;
  loc.Location _location = loc.Location();
  bool _isLocationInitialized = false;
  Set<gmaps.Marker> _markers = {};
  Set<gmaps.Polyline> _polylines = {};
  gmaps.LatLng? _destination;
  final TextEditingController _destinationController = TextEditingController();
  gmaps.GoogleMapController? _mapController;
  double _distanceInKm = 0.0;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      loc.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) return;
      }

      _location.onLocationChanged.listen((loc.LocationData currentLocation) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(Duration(seconds: 5), () {
          setState(() {
            _currentLocation = currentLocation;
            _isLocationInitialized = true;
            _updateMarkers();
            _fetchRoute();
            _updateCameraPosition();
            _calculateDistance();
          });
        });
      });

      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
        _isLocationInitialized = true;
        _updateMarkers();
        _fetchRoute();
        _updateCameraPosition();
        _calculateDistance();
      });
    } catch (e) {
      print("Error initializing location: $e");
    }
  }

  Future<void> _setDestinationFromAddress(String address) async {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(address);
      if (locations.isNotEmpty) {
        geo.Location location = locations.first;
        setState(() {
          _destination = gmaps.LatLng(location.latitude, location.longitude);
          _updateMarkers();
          _fetchRoute();
          _calculateDistance();
        });
      }
    } catch (e) {
      print("Error setting destination from address: $e");
    }
  }

  Future<void> _fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_destination!.latitude},${_destination!.longitude}&mode=driving&key=AIzaSyAwT3N1JBZqjDCG-GVrHQORMNOUFILUwt8';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data); // Debugging: Print the entire response to debug
        if (data['status'] == 'ZERO_RESULTS') {
          _drawStraightLine();
          return;
        }

        final routes = data['routes'] as List;
        if (routes.isNotEmpty) {
          final polyline = routes[0]['overview_polyline']['points'] as String;
          final points = _decodePoly(polyline);
          setState(() {
            _polylines.clear(); // Clear previous polylines
            _polylines.add(
              gmaps.Polyline(
                polylineId: gmaps.PolylineId('route'),
                color: Color.fromARGB(255, 0, 0, 0),
                width: 5,
                points: points,
              ),
            );
          });
          print('Polyline points: $points'); // Debugging: Print the decoded points
        }
      } else {
        _drawStraightLine();
      }
    } catch (e) {
      print('Error fetching route: $e');
      _drawStraightLine();
    }
  }

  void _drawStraightLine() {
    if (_currentLocation != null && _destination != null) {
      setState(() {
        _polylines.clear(); // Clear previous polylines
        _polylines.add(
          gmaps.Polyline(
            polylineId: gmaps.PolylineId('straight_line'),
            color: Color.fromARGB(255, 0, 0, 0),
            width: 4,
            points: [
              gmaps.LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
              _destination!,
            ],
          ),
        );
      });
    }
  }

  List<gmaps.LatLng> _decodePoly(String encoded) {
    List<gmaps.LatLng> poly = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      gmaps.LatLng p = gmaps.LatLng((lat / 1E5), (lng / 1E5));
      poly.add(p);
    }
    return poly;
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear(); // Clear previous markers
      if (_currentLocation != null) {
        // _markers.add(
        //   gmaps.Marker(
        //     markerId: gmaps.MarkerId('currentLocation'),
        //     position: gmaps.LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        //     infoWindow: gmaps.InfoWindow(title: 'Current Location'),
        //     icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueAzure),
        //   ),
        // );
      }
      if (_destination != null) {
        _markers.add(
          gmaps.Marker(
            markerId: gmaps.MarkerId('destination'),
            position: _destination!,
            infoWindow: gmaps.InfoWindow(title: 'Destination'),
          ),
        );
      }
    });
  }

  void _updateCameraPosition() {
    if (_mapController != null && _currentLocation != null) {
      _mapController!.animateCamera(
        gmaps.CameraUpdate.newLatLng(
          gmaps.LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
        ),
      );
    }
  }

  void _calculateDistance() {
    if (_currentLocation != null && _destination != null) {
      double lat1 = _currentLocation!.latitude!;
      double lon1 = _currentLocation!.longitude!;
      double lat2 = _destination!.latitude;
      double lon2 = _destination!.longitude;
      _distanceInKm = _calculateHaversineDistance(lat1, lon1, lat2, lon2);
    }
  }

  double _calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Radius of the Earth in kilometers
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 200,
        maxHeight: MediaQuery.of(context).size.height * 0.73,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        panel: _buildPanel(),
        body: Stack(
          children: [
            _buildMap(),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressInput(),
          SizedBox(height: 16),
          Text(
            'Distance: ${_distanceInKm.toStringAsFixed(2)} km',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildCourierInfo(),
          Divider(height: 30),
          _buildPackageStatus(),
          Divider(height: 30),
          _buildShipperInfo(),
        ],
      ),
    );
  }

  Widget _buildAddressInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _destinationController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: 'Enter destination address',
          suffixIcon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _setDestinationFromAddress(_destinationController.text);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return gmaps.GoogleMap(
      initialCameraPosition: gmaps.CameraPosition(
        target: gmaps.LatLng(0, 0),
        zoom: 14.0,
      ),
      markers: _markers,
      polylines: _polylines,
      myLocationEnabled: true,
      onMapCreated: (gmaps.GoogleMapController controller) {
        _mapController = controller;
      },
    );
  }

Widget _buildCourierInfo() {


  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Driver's Image
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('images/man.jpeg'), // Add your driver image here
        ),
        SizedBox(width: 16),
        // Driver's Information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
          "Driver : dev Singh",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Vehicle: Bus XYZ123',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    ),
  );
}


Widget _buildPackageStatus() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Task status: ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: true,
        indicatorStyle: IndicatorStyle(
          width: 20,
          height: 40,
          color: Colors.blue,
          padding: EdgeInsets.all(6),
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Location'),
                  Text(
                    "Jaipur",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.start,
        indicatorStyle: IndicatorStyle(
          width: 20,
          height: 40,
          color: Colors.blue,
          padding: EdgeInsets.all(6),
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('In process'),
                ],
              ),
            ),
          ),
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.start,
        isLast: true,
        indicatorStyle: IndicatorStyle(
          width: 20,
          height: 40,
          color: Colors.blue,
          padding: EdgeInsets.all(6),
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('End Location'),
                  Text(
                    "Jaipur",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildShipperInfo() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  // Your code for the button action
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue // Optional: set background color
                ),
                child: Text(
                  'End Task',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Optional: set text color
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              child: Text('Need fuel?',style: TextStyle(fontSize: 16), ),
              onPressed: () { Get.to(()=>FuelForm()); },
            ),
          ],
        );
      
  }
}