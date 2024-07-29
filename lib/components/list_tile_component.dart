import 'package:abramo_coffee/resources/color.dart';
import 'package:flutter/material.dart';

class ListTileComponent extends StatelessWidget {
  const ListTileComponent({
    super.key,
    required this.title,
    required this.desc,
    required this.onTap,
  });
  final String title;
  final String desc;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          title,
          style: const TextStyle(
            color: cYellowDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          desc,
          style: const TextStyle(
            color: cYellowPrimary,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          color: cYellowDark,
        ),
        onTap: onTap,
      ),
    );
  }
}
