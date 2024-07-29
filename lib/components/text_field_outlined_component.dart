import 'package:flutter/material.dart';
import '../resources/color.dart';

class TextFieldOutlinedComponent extends StatelessWidget {
  const TextFieldOutlinedComponent({
    super.key,
    required this.validator,
    required this.hintText,
    required this.textController,
    required this.keyboardType,
  });

  final String validator;
  final String hintText;
  final TextEditingController textController;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validator;
        }
        return null;
      },
      controller: textController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: cGray),
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
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
