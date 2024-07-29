import 'package:flutter/material.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

class DateTimeFieldComponent extends StatelessWidget {
  const DateTimeFieldComponent({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.obsecureText,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obsecureText;

  _selectDate(BuildContext context, TextEditingController controller) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(DateTime.now().year + 10),
      onConfirm: (time) {
        controller.text = DateFormat('yyyy-MM-dd hh:mm:ss').format(time);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obsecureText,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context, controller);
      },
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
        fillColor: cWhite,
        prefixIcon: Icon(
          Icons.calendar_today_rounded,
          color: Colors.black.withOpacity(0.25),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cYellowDark),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: cYellowDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: cYellowDark),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
