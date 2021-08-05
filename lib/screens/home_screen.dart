import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/firebase/FirebaseHandler.dart';
import 'package:todo/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseHandler.getAuthInstance().signOut();
              GoogleSignIn().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.id, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
