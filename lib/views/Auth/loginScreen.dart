import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fleetuser/Controller/AuthController/loginController.dart';
import 'package:fleetuser/views/Driver/deatailpage/fuel_form.dart';
import 'package:fleetuser/views/homePage/homePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginController loginController;
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    loginController = Get.put(LoginController());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        loginController.setDriver(_tabController.index == 0);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset("images/ParasLogo.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign in to continue',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[600],
                      tabs: [
                        Tab(text: 'Driver'),
                        Tab(text: 'Supervisor'),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 400,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(child: buildLoginForm('D')),
                        SingleChildScrollView(child: buildLoginForm('SP')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(String userType) {
    return Column(
      children: [
        buildTextField(
          controller: _nameController,
          hintText: 'Email or Mobile number',
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: 20),
        buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
        ),
        SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Map<String, dynamic> loginResult = await loginController.login(
                  _nameController.text,
                  _passwordController.text,
                  userType: userType,
                );

                if (loginResult['success']) {
                  if (userType == 'D') {
                    Get.to(() => FuelForm());
                    print('Navigating to Driver Home Page');
                  } else {
                    Get.to(() => HomePage());
                    print('Navigating to Supervisor Home Page');
                  }
                } else {
                  Get.snackbar(
                    'Login Failed',
                    loginResult['message'],
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              }
            },
            child: Obx(() {
              return loginController.isLoading.value
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  );
            }),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              // Handle forgot password
            },
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField({required TextEditingController controller, required String hintText, required IconData prefixIcon, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
