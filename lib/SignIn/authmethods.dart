import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //get current user
  getCurrentUser() async {
    return auth.currentUser;
  }

  Future signOut(context) async {
    // ここでキーを外す
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) => auth.signOut().then((value) => {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const SwitchScreen(),
                transitionDuration: const Duration(seconds: 0),
              ))
        }));
  }
}