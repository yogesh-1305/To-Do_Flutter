import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/email_verify_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _auth = FirebaseAuth.instance;
  if (_auth.currentUser == null) {
    runApp(Main(
      route: LoginScreen.id,
    ));
  } else {
    runApp(Main(
      route: HomeScreen.id,
    ));
  }
}

class Main extends StatelessWidget {
  Main({@required this.route});

  final String? route;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: route,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        VerifyEmail.id: (context) => VerifyEmail(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
