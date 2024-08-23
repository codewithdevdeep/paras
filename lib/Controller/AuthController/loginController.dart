import 'package:fleetuser/Controller/AuthController/auth_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginController extends GetxController {
  RxBool isDriver = false.obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs; // Use RxString here
  RxString name = ''.obs; // Add RxString for storing name

  final Dio _dio = Dio();
  late final AuthController _authController;

  get user => null;

  @override
  void onInit() {
    super.onInit();
    _authController = Get.find<AuthController>();
  }

  bool getDriver() => isDriver.value;

  void setDriver(bool status) => isDriver.value = status;

  Future<Map<String, dynamic>> login(String email, String password, {required String userType}) async {
    isLoading.value = true;
    try {
      print('Starting login attempt for email: $email with user type: $userType');
      final response = await _dio.post(
        'https://kriscenttechnohub.in/demo/paras-travels/api/login-user',
        data: {
          'email': email,
          'password': password,
          'user_type': userType,
        },
      );

      print('Raw response: ${response.toString()}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data: ${response.data}');

      isLoading.value = false;

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data is String 
            ? jsonDecode(response.data) 
            : response.data;

        if (responseData['status'] == true && responseData['api_token'] != null) {
          String token = responseData['api_token'];
          _authController.setAuthToken(token);

          // Save the token to shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('api_token', token);

          Map<String, dynamic> userInfo = responseData['result'][0];
         // Update email here
        // Update name here

          return {
            'success': true,
            'message': 'Login successful',
            'token': token,
            'user': userInfo
          };
        } else {
          return {'success': false, 'message': 'Invalid credentials'};
        }
      } else {
        return {'success': false, 'message': 'Login failed. Please try again.'};
      }
    } on DioException catch (e) {
      print('DioException: $e');
      isLoading.value = false;
      if (e.response != null) {
        final errorMessage = e.response?.data is String
            ? e.response?.data
            : e.response?.data['message'] ?? 'Login failed';
        return {'success': false, 'message': errorMessage};
      } else {
        return {'success': false, 'message': 'Network error. Please check your connection.'};
      }
    } catch (e) {
      print('Unexpected error: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');
      isLoading.value = false;
      return {'success': false, 'message': 'An unexpected error occurred: ${e.toString()}'};
    }
  }
 Future<void> _loadName() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedName = prefs.getString('name'); // Use the key for the name

      if (storedName != null) {
        name.value = storedName;
      } else {
        print('Name not found in SharedPreferences.');
      }
    } catch (e) {
      print('Error loading name: $e');
    }
  }
}







