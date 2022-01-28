import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/authmethods.dart';

class Signout extends StatelessWidget {
  const Signout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          AuthMethods().signOut(context);
        },
        child: const Text('ログアウト'),
      )),
    );
  }
}