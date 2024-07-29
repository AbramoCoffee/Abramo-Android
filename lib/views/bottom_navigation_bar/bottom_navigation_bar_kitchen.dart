import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/views/history/history_kithcen_view.dart';
import 'package:abramo_coffee/views/history/history_view.dart';
import 'package:abramo_coffee/views/home/home_kitchen_view.dart';
import 'package:abramo_coffee/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarKitchen extends StatefulWidget {
  const BottomNavigationBarKitchen({super.key});

  @override
  State<BottomNavigationBarKitchen> createState() =>
      _BottomNavigationBarKitchen();
}

class _BottomNavigationBarKitchen extends State<BottomNavigationBarKitchen> {
  List<Widget> bodyView = const [
    HistoryKitchenView(),
    HomeKitchenView(),
    ProfileView()
  ];

  int _index = 0;

  void _onTapItem(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyView[_index],
      bottomNavigationBar: SizedBox(
        // height: 89,
        child: BottomNavigationBar(
            fixedColor: cDarkYellow,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            onTap: _onTapItem,
            currentIndex: _index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: "Ketersediaan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
