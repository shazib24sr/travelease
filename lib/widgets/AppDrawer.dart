import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/widgets/login.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return drawerAppState();
  }
}

class drawerAppState extends State<AppDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: UserAccountsDrawerHeader(
              accountName: Text(
                UserData.username ?? '',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                UserData.email ?? '',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/tt.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Plan Your Journey"),
            onTap: () {
              Navigator.pushNamed(context, "/create_journey");
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            onTap: () {
              Navigator.pushNamed(context, "/about");
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp),
            title: Text("Log Out"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
