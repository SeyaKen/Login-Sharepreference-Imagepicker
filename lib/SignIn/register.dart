import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:machupichu/SignIn/ninshow.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  String email = '';
  String password = '';
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


  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.login_rounded,
                    color: Color(0xFF00BAFF),
                  ),
                  label: const Text(
                    'ログイン画面へ',
                    style: TextStyle(color: Color(0xFF00BAFF)),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            )),
      ),
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 55,
                    child: Image.asset(
                      'images/forchuo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        '※大学メールアドレスでないと登録できません。',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      // validator: (val) =>
                      //     val!.isEmpty || !val.contains('@g.chuo-u.ac.jp')
                      //         ? '正しいメールアドレスを入力してください'
                      //         : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'メールアドレス',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: _usernameController,
                          validator: (val) =>
                              validateStructure(_usernameController.text)
                                  ? null
                                  : '7文字以上で、ローマ字、数字を含んでください',
                          obscureText: eye,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: 'パスワード',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                      Positioned(
                        top: 11,
                        right: 15,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              eye = !eye;
                            });
                          },
                          child: Icon(
                            eye
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 23,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: validateStructure(_usernameController.text) &&
                                email
                                    .substring(email.length - 15)
                                    .contains('@g.chuo-u.ac.jp')
                            ? const Color(0xFFed1b24)
                            : const Color(0xFFed1b24).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                email.length > 15 &&
                                validateStructure(_usernameController.text)) {
                              sendOTP();
                              Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                             NinShow(email, password),
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                      ));
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Center(
                              child: Text(
                                '認証コードを送信する',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}