import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo/buttons/custom_button.dart';
import 'package:todo/firebase/FirebaseHandler.dart';
import 'package:todo/screens/email_verify_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal, Colors.pink]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Flexible(
                  child: Image.asset(
                    'images/logo.png',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              RoundButton(
                text: 'Sign in with Email',
                function: () {
                  Navigator.pushNamed(context, VerifyEmail.id);
                },
                color: Colors.white,
                elevation: 10,
                icon: Icon(Icons.mail_outline),
              ),
              RoundButton(
                text: 'Sign in with Google',
                function: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await FirebaseHandler.getInstance()
                        .signInWithGoogle(context);
                    if (user.credential != null) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.id, (route) => false);
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                color: Colors.white,
                elevation: 10,
                icon: Image.asset(
                  'images/google-logo.png',
                  height: 25,
                  width: 25,
                ),
              ),
              RoundButton(
                text: 'Enter as Guest',
                function: () {
                  setState(() {
                    showSpinner = true;
                    sleep(Duration(seconds: 2));
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.id, (route) => false);
                  });
                },
                color: Colors.white,
                elevation: 10,
                icon: Icon(Icons.person_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
