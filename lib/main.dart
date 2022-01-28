import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/authmethods.dart';
import 'package:machupichu/SignIn/sharedpref_helper.dart';
import 'package:machupichu/SignIn/switch.dart';
import 'package:machupichu/main_paga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? uid = await SharedPreferencesHelper().getUserId();
  runApp(MyApp(uid: uid));
}

class MyApp extends StatefulWidget {
  final String? uid;
  const MyApp({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (widget.uid != null) {
          return const MainPage(currenttab: 0);
        } else {
          return const SwitchScreen();
        }
      }),
    );
  }
}