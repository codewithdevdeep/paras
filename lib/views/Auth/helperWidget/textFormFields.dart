import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData suffixIcon;
  final Function(String)? onChanged;
  final String?Function(String?)? validation;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    this.onChanged, this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validation,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(suffixIcon),
        focusedBorder: OutlineInputBorder(
          
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 0, 174, 243)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
            color: Color.fromARGB(255, 0, 174, 243)),
        ),
      ),
    );
  }
}