import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/authservice.dart';

class NinShow extends StatefulWidget {
  String email, password;
  NinShow(this.email, this.password, {Key? key}) : super(key: key);
  @override
  _NinShowState createState() => _NinShowState(email, password);
}

class _NinShowState extends State<NinShow> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  _NinShowState(this.email, this.password);
  String ninshow = '';
  dynamic error;
  bool eye = true;
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = EmailAuth(
      sessionName: "中央大学のための時間割の認証コードです。",
    );
  }

  void sendOTP() async {
    bool res = await emailAuth.sendOtp(recipientMail: email);
    if (res) {
      print('送信しました');
    } else {
      CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("閉じる"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        title: const Text('認証コードを送信できませんでした。メールアドレスをもう一度ご確認ください。'),
      );
    }
  }

  void verifyOTP() async {
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: ninshow);
    print(res);
    if (res) {
      try {
        print('成功');
        await _auth.registerWithEmailAndPassword(
            context, email.toString().trim(), password.toString().trim());
      } catch (e) {
        print(e.toString());
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("閉じる"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ], title: const Text('正しい認証コードを入力してください'));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const Flexible(
                      child: Text(
                        'コードを入力してください',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: 'appautheticator.1',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    'というメールアドレスから届いたメールアドレスに記載されているコードを入力してください。',
                                style: TextStyle(color: Colors.black)),
                          ]))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() => ninshow = val);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: '認証コード（6桁）',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 17),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (email.isNotEmpty) {
                              verifyOTP();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ninshow.length == 6
                            ? const Color(0xFFed1b24)
                            : const Color(0xFFed1b24).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45,
                            child: const Center(
                              child: Text(
                                '新規登録',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            email.length > 15 &&
                            email
                                .substring(email.length - 15)
                                .contains('@g.chuo-u.ac.jp')) {
                          sendOTP();
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Center(
                          child: Text(
                            '認証コードを再送信する',
                            style: TextStyle(
                                color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}