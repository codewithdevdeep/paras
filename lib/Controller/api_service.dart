import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/assigned_task_model.dart';


class ApiService {
  static const String baseUrl = 'https://kriscenttechnohub.in/demo/paras-travels/api/assigned-task'; // Replace with your actual API base URL

  /// Fetches a list of trips from the API with the provided [authToken].
  static Future<List<Driver>> fetchTrips(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/trips'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Driver.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load trips: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load trips: $e');
    }
  }

  /// Fetches details of a specific driver using [driverId] and [authToken].
  static Future<Driver> fetchDriverDetails(int driverId, String authToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/drivers/$driverId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Driver.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load driver details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load driver details: $e');
    }
  }

  /// Updates the status of a driver using [driverId], [status], and [authToken].
  static Future<bool> updateDriverStatus(int driverId, String status, String authToken) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/drivers/$driverId/status'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update driver status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update driver status: $e');
    }
  }

  /// Creates a new driver with the given [driver] details and [authToken].
  static Future<Driver> createDriver(Driver driver, String authToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/drivers'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(driver.toJson()),
      );

      if (response.statusCode == 201) {
        return Driver.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create driver: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create driver: $e');
    }
  }

  /// Deletes a driver with the specified [driverId] and [authToken].
  static Future<bool> deleteDriver(int driverId, String authToken) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/drivers/$driverId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete driver: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete driver: $e');
    }
  }
}
