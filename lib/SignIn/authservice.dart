import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/sharedpref_helper.dart';
import 'package:machupichu/main_paga.dart';
import 'package:machupichu/register/name_register.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // メールアドレスとパスワードでログイン
  Future signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // ログインしているのかここで確認
      await auth.signInWithEmailAndPassword(email: email, password: password);
      try {
        final check = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
        check['pictureURL'].isNotEmpty
        ? 
        SharedPreferencesHelper().saveUserId(auth.currentUser!.uid).then((value) => 
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainPage(
                currenttab: 0,
              ),
              transitionDuration: const Duration(seconds: 0),
            ))
        )
        : print('プロフィール入力が完了していません。');
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const NameRegister(),
              transitionDuration: const Duration(seconds: 0),
            ));
      } catch (e) {
        print('プロフィール入力が完了していません。');
        print(e.toString());
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const NameRegister(),
              transitionDuration: const Duration(seconds: 0),
            ));
      }
    } catch (e) {
      print(e.toString());
      if (e.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        errorBox(context, 'パスワードが間違っています。');
      } else if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        errorBox(context, '一致するユーザーが見つかりません。新規登録画面から登録してください。');
      }
    }
  }

  // メールアドレスとパスワードで登録
  Future registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const NameRegister(),
                transitionDuration: const Duration(seconds: 0),
              )));
    } catch (e) {
      print('エラーが発生しました');
      print(e.toString());
      errorBox(
          context,
          e.toString() ==
                  '[firebase_auth/email-already-in-use] The email address is already in use by another account.'
              ? '既に登録済みです。ログイン画面からログインしてください。'
              : 'メールアドレスまたはパスワードが違います。');
    }
  }

  void errorBox(context, e) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("閉じる"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          title: const Text('エラー'),
          content: Text(e.toString()),
        );
      },
    );
  }
}
