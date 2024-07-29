import 'package:abramo_coffee/resources/color.dart';
import 'package:flutter/material.dart';

class SearchFieldComponent extends StatelessWidget {
  const SearchFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    required this.onChanged,
    // required this.onTap,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Function(String)? onChanged;
  // final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: cDarkYellow),
      cursorColor: cDarkYellow,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: cDarkYellow),
          focusColor: cDarkYellow,
          // suffixIcon: IconButton(
          //     icon: Icon(icon, color: cDarkYellow),
          //     onPressed: () {
          //       onTap;
          //     }),
          prefixIcon: IconButton(
              icon: Icon(icon, color: cDarkYellow), onPressed: () {}),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: cDarkYellow),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: cDarkYellow),
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
