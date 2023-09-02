// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:evoucher/components/event_item.dart';
import 'package:evoucher/components/navbar/app_user_navbar.dart';
import 'package:evoucher/components/navbar/organizer_nav_bar.dart';
import 'package:evoucher/components/navbar/restaurant_navbar.dart';
import 'package:evoucher/components/voucher_item.dart';
import 'package:evoucher/network/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import http package and convert dart file
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({super.key});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  List<dynamic> allEvents = [];
  List<dynamic> allVouchers = [];

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

  // get events
  Future<int> get_events() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var url = Uri.parse(APIEndpoints.allEvents);
    var response = await http.get(url, headers: {
      "Authorization": "Token ${token.toString()}",
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var events = data["events"];
      setState(() {
        allEvents = events;
      });
      print(allEvents);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response.statusCode;
  }

  // get vouchers
  Future<int> get_vouchers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var url = Uri.parse(APIEndpoints.allVouchers);
    var response = await http.get(url, headers: {
      "Authorization": "Token ${token.toString()}",
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var vouchers = data["vouchers"];
      setState(() {
        allVouchers = vouchers;
      });
      print(allVouchers);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response.statusCode;
  }

  @override
  void initState() {
    super.initState();
    get_events();
    get_vouchers();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events and Vouchers"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
      ),
      body: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.deepPurple,
              tabs: [
                Tab(text: "Events"),
                Tab(text: "Vouchers"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "All Events",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        EventItemCard(
                          eventName: "Graduation Night",
                          date: '12/12/2021',
                        ),
                        SizedBox(height: 8),
                        EventItemCard(
                          eventName: "Dinner and Awards",
                          date: '12/12/2021',
                        ),
                        SizedBox(height: 8),
                        EventItemCard(
                          eventName: "Leavers Service",
                          date: '12/12/2021',
                        ),
                        SizedBox(height: 8),
                        EventItemCard(
                          eventName: "Hackathon Kickoff",
                          date: '12/12/2021',
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "All Vouchers",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        VoucherItemCard(
                          eventName: 'Dinner and Awards',
                          voucherID: 'EV#123456',
                          voucherCreator: 'Fahd Mohammed',
                          voucherDate: '2023-08-12',
                        ),
                        SizedBox(height: 8),
                        VoucherItemCard(
                          eventName: 'Dinner and Awards',
                          voucherID: 'EV#123456',
                          voucherCreator: 'Fahd Mohammed',
                          voucherDate: '2023-08-12',
                        ),
                        SizedBox(height: 8),
                        VoucherItemCard(
                          eventName: 'Dinner and Awards',
                          voucherID: 'EV#123456',
                          voucherCreator: 'Fahd Mohammed',
                          voucherDate: '2023-08-12',
                        ),
                        SizedBox(height: 8),
                        VoucherItemCard(
                          eventName: 'Dinner and Awards',
                          voucherID: 'EV#123456',
                          voucherCreator: 'Fahd Mohammed',
                          voucherDate: '2023-08-12',
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: userRole == "APP_USER"
          ? AppUserNavBar(selectedIndex: 2)
          : userRole == "ORGANIZER"
              ? OrganazinerNavBar(
                  selectedIndex: 2,
                )
              : RestaurantNavBar(selectedIndex: 2),
    );
  }
}
