import 'package:flutter/material.dart';
import 'package:travel/widgets/About.dart';
import 'package:travel/widgets/CreateJourney.dart';

import 'package:travel/widgets/VisitSpot.dart';
import 'package:travel/widgets/appDrawer.dart';
import 'package:travel/widgets/createJourneySaveData.dart';
import 'package:travel/widgets/detailView.dart';
import 'package:travel/widgets/home.dart';
import 'package:travel/widgets/login.dart';

import 'package:travel/widgets/register.dart';
//import 'package:travel/widgets/gmap.dart';
import 'firebase_options.dart'; // Adjust the file name if necessary
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(travelApp());
}

class travelApp extends StatefulWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  State<StatefulWidget> createState() {
    return travelAppState();
  }
}

class travelAppState extends State<travelApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //"/setting": (BuildContext ctx) => ),
        "/register": (BuildContext ctx) => RegisterPage(),
        "/home": (BuildContext ctx) => Home(),
        "/about": (BuildContext ctx) => About(),
        "/login": (BuildContext ctx) => LoginPage(),
        "/create_journey": (BuildContext ctx) => CreateJourney(),
        "/createdJourney": (BuildContext ctx) => CreatedJourney(),
        // '/visitSpotGrid': (context) => VisitSpotGrid(index),
        //'/visitSpotMap': (context) => VisitSpotMap(),
      },
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
