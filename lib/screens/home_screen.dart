import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/firebase/FirebaseHandler.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/shared_prefs/SharedPrefs.dart';
import 'package:todo/widgets/task_list.dart';

import 'AddTaskBottomSheet.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.person_outline),
        title: Text('todo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseHandler.getAuthInstance().signOut();
              GoogleSignIn().signOut();
              SharedPrefs.saveGuestUser(false);
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.id, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskBottomSheet(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: TaskList(),
      ),
    );
  }
}
