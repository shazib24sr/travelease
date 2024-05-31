import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserData {
  static String? username;
  static String? email;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Icon(
                          Icons.flight_takeoff_rounded,
                          size: 100,
                          color: Color.fromARGB(255, 0, 127, 247),
                        ),
                      ),
                      Icon(
                        Icons.train,
                        size: 100,
                        color: Color.fromARGB(255, 0, 127, 247),
                      ),
                      Icon(
                        Icons.pedal_bike_sharp,
                        size: 100,
                        color: Color.fromARGB(255, 0, 127, 247),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      // _signUp();
                      CollectionReference collRef =
                          FirebaseFirestore.instance.collection("project_db");
                      try {
                        QuerySnapshot<Map<String, dynamic>> snapshot =
                            await FirebaseFirestore.instance
                                .collection("project_db")
                                .where("email", isEqualTo: email)
                                .limit(1) // Limit to 1 document
                                .get();

                        if (snapshot.docs.isNotEmpty) {
                          // Email exists in Firestore
                          DocumentSnapshot<Map<String, dynamic>> userDoc =
                              snapshot.docs.first;
                          String storedPassword = userDoc["password"];
                          String storedUsername = userDoc["username"];
                          String storedEmail = userDoc["email"];
                          setState(() {
                            UserData.username = storedUsername;
                            UserData.email = storedEmail;
                          });

                          if (storedPassword == password) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Logged in'),
                                duration: Duration(seconds: 1),
                              ),
                            );

                            // Navigate to home page after successful login
                            Navigator.pushNamed(context, "/home");
                          }
                        } else {
                          // Email not found in Firestore
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Incorrect email/password'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Handle email not found
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error during login: $e'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 127, 247),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text('Create an Account'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
