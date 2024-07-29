import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color color;
  final Icon icon;

  const IconButtonComponent({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0))),
    );
  }
}
