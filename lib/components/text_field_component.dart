import 'package:abramo_coffee/resources/color.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.controller,
      // required this.validator,
      required this.hintText,
      this.icon,
      required this.obsecureText,
      required this.keyboarType});
  final TextEditingController controller;
  // final String validator;
  final String hintText;
  final IconData? icon;
  final bool obsecureText;
  final TextInputType keyboarType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return validator;
      //   }
      //   return null;
      // },
      controller: controller,
      keyboardType: keyboarType,
      obscureText: obsecureText,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: const TextStyle(color: cYellowDark),
        // hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
        fillColor: cWhite,
        prefixIcon: Icon(
          icon,
          color: cYellowDark,
        ),
        focusColor: cYellowDark,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: cDarkYellow),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
