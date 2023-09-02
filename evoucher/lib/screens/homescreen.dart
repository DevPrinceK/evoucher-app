// ignore_for_file: file_names, avoid_print

import 'package:evoucher/components/navbar/app_user_navbar.dart';
import 'package:evoucher/components/navbar/organizer_nav_bar.dart';
import 'package:evoucher/components/navbar/restaurant_navbar.dart';
import 'package:evoucher/screens/dynamic/app_user/app_user_home_screen.dart';
import 'package:evoucher/screens/dynamic/restaurant/restaurant_home_screen.dart';
import 'package:evoucher/screens/statsScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userRole = "APP_USER";
  // Get the user role from shared preferences
  Future<void> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roleFromPrefs =
        prefs.getString('role'); // Use a different variable name
    print("Role Before setState(): $roleFromPrefs");
    setState(() {
      userRole = roleFromPrefs ?? "APP_USER"; // Set the class-level userRole
    });
    print("Role After setState(): $userRole");
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepPurple,
        backgroundColor: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
        elevation: 0,
        title: const Text(
          'eVoucher',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: userRole == "APP_USER"
          ? const AppUserStatsScreen()
          : userRole == "ORGANIZER"
              ? const StatsScreen()
              : const RestaurantUserStatsScreen(),
      bottomNavigationBar: userRole == "APP_USER"
          ? AppUserNavBar(selectedIndex: 0)
          : userRole == "ORGANIZER"
              ? OrganazinerNavBar(
                  selectedIndex: 0,
                )
              : RestaurantNavBar(selectedIndex: 0),
    );
  }
}
