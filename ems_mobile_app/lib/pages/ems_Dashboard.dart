import 'package:flutter/material.dart';
import 'dashboard/dashProfile.dart';
import 'dashboard/dashSummery.dart';
import 'dashboard/dashTiles.dart';
import 'dashboard/ems_Drawer.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = 'Dashboard';
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notification_important_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month_outlined)),
        ],
      ),
      drawer: const EMSDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            DashboardProfile(),
            DashSummery(),
            DashboardTiles(),
          ],
        ),
      ),
    );
  }
}
