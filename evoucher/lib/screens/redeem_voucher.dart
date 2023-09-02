import 'package:evoucher/components/navbar/app_user_navbar.dart';
import 'package:evoucher/components/navbar/organizer_nav_bar.dart';
import 'package:evoucher/components/navbar/restaurant_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedeemVoucherScreen extends StatefulWidget {
  const RedeemVoucherScreen({super.key});

  @override
  State<RedeemVoucherScreen> createState() => _RedeemVoucherScreenState();
}

class _RedeemVoucherScreenState extends State<RedeemVoucherScreen> {
  double get deviceWidth => MediaQuery.of(context).size.width;

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

  // show dialog
  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: const Text("Voucher Verifiied!"),
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

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redeem Voucher"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0x32, 0xB7, 0x68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Redeem Voucher",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0x32, 0xB7, 0x68),
                  ),
                ),
                const SizedBox(height: 15),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Voucher Code",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Redeemer Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                // button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      _showDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 0x32, 0xB7, 0x68),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Redeem",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: userRole == "APP_USER"
          ? AppUserNavBar(selectedIndex: 3)
          : userRole == "ORGANIZER"
              ? OrganazinerNavBar(
                  selectedIndex: 3,
                )
              : RestaurantNavBar(selectedIndex: 3),
    );
  }
}
