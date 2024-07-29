import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:flutter/material.dart';

class MenuProfileComponent extends StatelessWidget {
  const MenuProfileComponent(
      {super.key, required this.icon, required this.name, this.onTap});

  final IconData icon;
  final String name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: cYellowDark),
            borderRadius: BorderRadius.circular(12),
            color: cWhite),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: cYellowDark),
            Text(name, style: bold.copyWith(fontSize: 15, color: cYellowDark)),
            const Icon(
              Icons.arrow_forward_ios,
              color: cYellowDark,
            )
          ],
        ),
      ),
    );
  }
}
