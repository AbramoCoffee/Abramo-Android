import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/views/history/history_view.dart';
import 'package:abramo_coffee/views/home/home_menu_view.dart';
// import 'package:abramo_coffee/views/order/order_view.dart';
import 'package:abramo_coffee/views/profile/profile_view.dart';
import 'package:abramo_coffee/views/report/income/income_report_view.dart';
import 'package:abramo_coffee/views/report/report_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarOwner extends StatefulWidget {
  const BottomNavigationBarOwner({super.key});

  @override
  State<BottomNavigationBarOwner> createState() =>
      _BottomNavigationBarOwnerState();
}

class _BottomNavigationBarOwnerState extends State<BottomNavigationBarOwner> {
  List<Widget> bodyView = const [
    HomeMenuView(),
    HistoryView(),
    // OrderView(),
    // ReportView(),
    IncomeReportView(),
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
                icon: Icon(Icons.history),
                label: "Riwayat",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.add),
              //   label: "Pesanan",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: "Laporan",
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
