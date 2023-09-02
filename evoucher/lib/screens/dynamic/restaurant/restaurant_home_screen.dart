// ignore_for_file: use_build_context_synchronously

// ignore: unused_import
import 'package:evoucher/consts/colors.dart';
import 'package:evoucher/network/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import http package and convert dart file
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantUserStatsScreen extends StatefulWidget {
  const RestaurantUserStatsScreen({super.key});

  @override
  State<RestaurantUserStatsScreen> createState() =>
      _RestaurantUserStatsScreenState();
}

class _RestaurantUserStatsScreenState extends State<RestaurantUserStatsScreen> {
  // get device width
  double get deviceWidth => MediaQuery.of(context).size.width;
  // stats data
  Map<String, dynamic> createdData = {};

  // firstname
  String firstName = "";

  // flags
  bool isReloading = false;

  // get stats from the api
  Future<void> getEvents(bool reload) async {
    if (reload == true) {
      setState(() {
        isReloading = true;
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? fullname = prefs.getString('fullname');
    List<String> nameParts = fullname!.split(" ");
    firstName = nameParts[0];

    var url = Uri.parse(APIEndpoints.stats);
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token ${token.toString()}",
      },
    );

    if (response.statusCode == 200) {
      print("Vouchers Fetched Successfully");
      var data = jsonDecode(response.body)["stats"];
      setState(() {
        createdData = data["created"];
      });
      print(createdData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // show success dialog
  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("Success!"),
          content: SizedBox(
            height: 300,
            width: deviceWidth * 0.8,
            child: Column(
              children: [
                Image.asset("assets/images/success-check.png"),
              ],
            ),
          ),
        );
      },
    );
  }

  // show dialog to credit account
  Future<void> _showDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Funds"),
            content: SizedBox(
              width: deviceWidth * 0.8,
              // ignore: prefer_const_constructors
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Enter Amount"),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Text("Enter Card Number"),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Number',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {},
                child: const Text("Add"),
              ),
            ],
          );
        });
  }

  @override
  initState() {
    super.initState();
    getEvents(false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.2,
            width: double.infinity,
            color: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Hi $firstName",
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Welcome to eVoucher",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.7,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Vouchers Redeemed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0x32, 0xB7, 0x68),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            getEvents(true);
                            // Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                content: Text("Vouchers Refreshed"),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.refresh_sharp),
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
