import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/register/picture_register.dart';
import 'package:machupichu/services/database.dart';

class MajorRegister extends StatefulWidget {
  const MajorRegister({Key? key}) : super(key: key);

  @override
  _MajorRegisterState createState() => _MajorRegisterState();
}

class _MajorRegisterState extends State<MajorRegister> {
  String _hasBeenPressed = '法学部';
  final items = [
    '法学部',
    '経済学部',
    '商学部',
    '文学部',
    '総合政策学部',
    '国際経営学部',
    '国際情報学部',
    '理工学部',
  ];

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          )),
        body: Padding(
          padding: const EdgeInsets.only(bottom:30.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '学部を教えてください',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: InkWell(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: _hasBeenPressed == items[index]
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _hasBeenPressed = items[index];
                                });
                              }),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFED1B24),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: InkWell(
                  onTap: () async {
                    DatabaseService(uid).updateUserMajor(_hasBeenPressed);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => PictureRegister(),
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
          ),
        ),
      );
  }
}