import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/utilities/constants.dart';

class FirebaseHandler {
  static FirebaseHandler getInstance() {
    return FirebaseHandler();
  }

  static FirebaseAuth getAuthInstance() {
    return FirebaseAuth.instance;
  }

  static FirebaseFirestore getFirestoreInstance() {
    return FirebaseFirestore.instance;
  }

  void signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await getAuthInstance()
          .signInWithEmailAndPassword(email: email, password: password);
      dismissSnackBar(context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        createSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        createSnackBar(context, 'Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
