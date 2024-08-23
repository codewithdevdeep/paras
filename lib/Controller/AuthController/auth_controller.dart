import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxString authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the token from storage when the controller is initialized
    String? storedToken = _storage.read('api_token');
    if (storedToken != null) {
      authToken.value = storedToken;
    }
  }

  void setAuthToken(String token) {
    authToken.value = token;
    _storage.write('api_token', token);
  }

  String getAuthToken() {
    return authToken.value;
  }

  void clearAuthToken() {
    authToken.value = '';
    _storage.remove('api_token');
  }
}



