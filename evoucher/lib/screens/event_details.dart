// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:evoucher/components/navbar/app_user_navbar.dart';
import 'package:evoucher/components/navbar/organizer_nav_bar.dart';
import 'package:evoucher/components/navbar/restaurant_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventName;
  final String eventID;
  final String eventDate;
  final String eventCreator;
  const EventDetailScreen({
    super.key,
    required this.eventName,
    required this.eventID,
    required this.eventDate,
    required this.eventCreator,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
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
        title: Text(widget.eventName),
        backgroundColor: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Event Name"),
                  Text(
                    widget.eventName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Date"),
                  const Text(
                    "2023-08-30",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Creator Name"),
                  const Text(
                    "Prince Samuel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Creator Email"),
                  const Text(
                    "princesamuelpks@gmail.com",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // shape: const ShapeBorder(),
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: userRole == "APP_USER"
          ? AppUserNavBar(selectedIndex: 2)
          : userRole == "ORGANIZER"
              ? const OrganazinerNavBar(
                  selectedIndex: 2,
                )
              : const RestaurantNavBar(selectedIndex: 2),
    );
  }
}
