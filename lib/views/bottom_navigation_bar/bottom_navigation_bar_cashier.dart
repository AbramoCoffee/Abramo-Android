import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/views/history/history_view.dart';
// import 'package:abramo_coffee/views/home/home_menu_view.dart';
import 'package:abramo_coffee/views/order/order_view.dart';
import 'package:abramo_coffee/views/profile/profile_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarCashier extends StatefulWidget {
  const BottomNavigationBarCashier({super.key});

  @override
  State<BottomNavigationBarCashier> createState() =>
      _BottomNavigationBarCashierState();
}

class _BottomNavigationBarCashierState
    extends State<BottomNavigationBarCashier> {
  List<Widget> bodyView = const [
    // HomeMenuView(),
    OrderView(),
    HistoryView(),
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
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.home),
              //   label: "Home",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Riwayat",
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
