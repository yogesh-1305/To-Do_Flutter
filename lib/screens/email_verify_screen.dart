import 'package:flutter/material.dart';
import 'package:todo/buttons/custom_button.dart';
import 'package:todo/firebase/FirebaseHandler.dart';
import 'package:todo/shared_prefs/SharedPrefs.dart';
import 'package:todo/utilities/constants.dart';

import 'SavedUserBottomSheet.dart';

class VerifyEmail extends StatefulWidget {
  static const id = 'verify_email';

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  var email = '';
  var password = '';
  var savedEmail = '';
  var savedPassword = '';
  var emailTapped = false;

  @override
  void initState() {
    SharedPrefs.getMail().then((value) => savedEmail = value!);
    SharedPrefs.getPassword().then((value) => savedPassword = value!);
    super.initState();
  }

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Flexible(
                    child: Image.asset(
                      'images/logo.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                onTap: () {
                  if (!emailTapped && savedEmail.isNotEmpty) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => SavedUserBottomSheet(
                            email: savedEmail, password: savedPassword));
                    emailTapped = true;
                  }
                },
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
                decoration: inputFieldDecoration.copyWith(
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                    labelText: 'enter e-mail',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: [AutofillHints.password],
                decoration: inputFieldDecoration.copyWith(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    labelText: 'enter password',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    fillColor: Colors.white),
              ),
            ),
            RoundButton(
              text: 'Sign In',
              function: () {
                if (!isMailValid(email)) {
                  createSnackBar(context, 'Please enter a valid E-mail');
                } else if (password.isEmpty) {
                  createSnackBar(context, 'Please Enter a password!');
                } else {
                  createSnackBar(context, 'Logging you in...');
                  var _auth = FirebaseHandler.getInstance();
                  _auth.signUpWithEmailAndPassword(context, email, password);
                  SharedPrefs.saveUserEmailAndPassword(email, password);
                }
              },
              color: Colors.white,
              elevation: 10,
              icon: Icon(Icons.thumb_up_alt),
            ),
          ],
        ),
      ),
    );
  }
}
