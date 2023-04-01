import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
typedef onChange = void Function(String)?;

class CustomFormField extends StatelessWidget {
  Validator validator;
  onChange? onchange;
  String hintText;
  bool hideText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextEditingController? controller;

  CustomFormField(
    this.hintText, {
    required this.validator,
    this.controller,
    this.onchange,
    this.suffixIcon,
    this.prefixIcon,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchange,
      controller: controller,
      validator: validator,
      obscureText: hideText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
