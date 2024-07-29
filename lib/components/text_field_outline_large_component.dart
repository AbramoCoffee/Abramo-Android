import 'package:flutter/material.dart';
import '../resources/color.dart';

class TextFieldOutlinedLargeComponent extends StatelessWidget {
  const TextFieldOutlinedLargeComponent({
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
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
        maxLines: 6,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: cDarkYellow),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: cDarkYellow),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: cDarkYellow),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.only(top: 8),
    //   child: TextFormField(
    //     maxLines: 6,
    //     controller: textController,
    //     keyboardType: keyboardType,
    //     decoration: InputDecoration(
    //       hintText: hintText,
    //       contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    //       focusColor: cPrimaryGreen,
    //       focusedBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: cDarkYellow),
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //       enabledBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: cDarkYellow),
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //       border: OutlineInputBorder(
    //         borderSide: const BorderSide(color: cDarkYellow),
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //     ),
    //   ),
    // );
  }
}
