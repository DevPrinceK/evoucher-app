// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:evoucher/network/api_endpoints.dart';
import 'package:evoucher/screens/homescreen.dart';
import 'package:evoucher/screens/login_signup.dart';
import 'package:flutter/material.dart';
// import http package and convert dart file
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailSignupController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordSignupController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String role = "APP_USER";
  bool invalidEmailPassword = false;
  bool isLoading = false;

  // Make API call to login
  Future<int> _login(email, passowrd) async {
    // initialize shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Make API call
    var url = Uri.parse(APIEndpoints.login);
    var response = await http.post(
      url,
      body: {
        "username": _emailController.text,
        "password": _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Login successful
      print("Login successful");
      var data = jsonDecode(response.body);
      var userData = data["user"];
      var token = data["token"];
      print(userData);
      print(token);
      // Save token and user info
      await prefs.setString("token", data["token"]);
      await prefs.setString("fullname", userData["fullname"]);
      await prefs.setString("email", userData["email"]);
      await prefs.setString("role", userData["role"]);
      print(response.statusCode);
      return response.statusCode;
    } else {
      // Login failed
      print("Login failed");
      print(response.statusCode);
      print(response.reasonPhrase);
      return response.statusCode;
    }
  }

  // signup user
  Future<int> _signUpUser(fullname, email, passowrd, role) async {
    // initialize shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Make API call
    var url = Uri.parse(APIEndpoints.signup);
    var response = await http.post(
      url,
      body: {
        "fullname": fullname,
        "email": email,
        "password": passowrd,
        "role": role,
      },
    );

    if (response.statusCode == 201) {
      // User created
      print("User account created");
      var data = jsonDecode(response.body);
      var userData = data["user"];
      var token = data["token"];
      print(userData);
      print(token);
      // Save token and user info
      await prefs.setString("token", data["token"]);
      await prefs.setString("fullname", userData["fullname"]);
      await prefs.setString("email", userData["email"]);
      await prefs.setString("role", userData["role"]);
      print(response.statusCode);
      return response.statusCode;
    } else {
      // Login failed
      print("Login failed");
      print(response.statusCode);
      print(response.reasonPhrase);
      return response.statusCode;
    }
  }

  // BOTTOM SHEET
  Future<void> _showBottomSheet(BuildContext context, int indx) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DefaultTabController(
          initialIndex: indx,
          length: 2,
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const TabBar(
                  tabs: [
                    Tab(text: "Login"),
                    Tab(text: "Signup"),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Login tab content
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 35),
                              const Text(
                                "By signing in, you agree to our Terms of Use and Privacy Policy",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              invalidEmailPassword
                                  ? const Text(
                                      "Invalid Email or Password",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var email = _emailController.text;
                                    var password = _passwordController.text;

                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (email.isEmpty || password.isEmpty) {
                                      setState(() {
                                        invalidEmailPassword = true;
                                      });
                                      // snackbar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Invalid Email or Password"),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );

                                      return;
                                    }
                                    var res = await _login(email, password);
                                    if (res == 200) {
                                      // Login successful
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    } else {
                                      // Login failed
                                      setState(() {
                                        invalidEmailPassword = true;
                                      });
                                      // snackbar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Invalid Email or Password"),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Signup tab content
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _fullnameController,
                                decoration: const InputDecoration(
                                  labelText: "Fullname",
                                  hintText: "Enter your fullname",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _emailSignupController,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _passwordSignupController,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(
                                  labelText: "Confirm Password",
                                  hintText: "Confirm your password",
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 15),
                              DropdownButtonFormField<String>(
                                value: role,
                                decoration: const InputDecoration(
                                  labelText: "User Role",
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: "ORGANIZER",
                                    child: Text("Organizer"),
                                  ),
                                  DropdownMenuItem(
                                    value: "RESTAURANT",
                                    child: Text("Restaurant"),
                                  ),
                                  DropdownMenuItem(
                                    value: "APP_USER",
                                    child: Text("App User"),
                                  ),
                                ],
                                onChanged: (value) {
                                  // Handle dropdown value change
                                  setState(() {
                                    role = value!;
                                  });
                                  print("value changed to $value");
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "By signing up, you agree to our Terms of Use and Privacy Policy",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String fullName = _fullnameController.text;
                                    String userEmail =
                                        _emailSignupController.text;
                                    String password1 =
                                        _passwordSignupController.text;
                                    String password2 =
                                        _confirmPasswordController.text;
                                    String userRole = role;
                                    if (password1 == password2) {
                                      var res = await _signUpUser(
                                          fullName,
                                          userEmail,
                                          password1,
                                          role = userRole);
                                      if (res == 201) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Couldn't Signup User"),
                                          ),
                                        );
                                        return;
                                      }
                                      return;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Passwords Mismatch"),
                                        ),
                                      );
                                      return;
                                    }
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/evoucher-logo.png',
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Welcome to eVoucher",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text(
                  "Please login or signup to enjoy our services",
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 255, 0, 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // _showBottomSheet(context, 1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginSignUpScreen(indx: 1),
                      ),
                    );
                  },
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(
                  //       const Color.fromARGB(255, 158, 242, 160)),
                  // ),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: const Color.fromARGB(200, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // _showBottomSheet(context, 0);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginSignUpScreen(indx: 0),
                      ),
                    );
                  },
                  child: const Text("Login", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
