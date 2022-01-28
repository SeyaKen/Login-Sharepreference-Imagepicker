import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/register/major.dart';
import 'package:machupichu/services/database.dart';

class NameRegister extends StatefulWidget {
  const NameRegister({Key? key}) : super(key: key);

  @override
  _NameRegisterState createState() => _NameRegisterState();
}

class _NameRegisterState extends State<NameRegister> {
  String name = '';
  final _formKey = GlobalKey<FormState>();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                '名前を入力しましょう！',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  style: const TextStyle(fontSize: 17),
                  decoration: const InputDecoration(
                    hintText: '名前を入力',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  ),
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFED1B24),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: InkWell(
                    onTap: () async {
                      DatabaseService(uid).updateUserName(name);
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const MajorRegister(),
                              transitionDuration: const Duration(seconds: 0)));
                    },
                    child: SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Center(
                        child: Text(
                          '次のページへ行く',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}