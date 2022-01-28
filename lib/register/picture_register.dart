import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machupichu/main_paga.dart';
import 'package:machupichu/services/database.dart';
import 'package:provider/provider.dart';

class PictureRegister extends StatelessWidget {
  final picker = ImagePicker();

  String uid = FirebaseAuth.instance.currentUser!.uid;

  PictureRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseService>(
      create: (_) => DatabaseService(uid),
      child: Scaffold(
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child:
                  Consumer<DatabaseService>(builder: (context, model, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          '写真を設定しましょう！',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000000.0),
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: InkWell(
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Image.file(
                                  model.imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : Container(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: const Color(0xFFED1B24),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await model.showImagePicker();
                            },
                            child: const Center(
                              child: Text(
                                '写真をアップロードする',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            model.imageFile == null
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(actions: [
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          child: const Text("いいえ"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                            textStyle: const TextStyle(
                                                color: Colors.red),
                                            isDefaultAction: true,
                                            child: const Text("はい"),
                                            onPressed: () async {
                                              await model.addImage();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage(
                                                      currenttab: 0,
                                                    ),
                                                  ));
                                            })
                                      ], title: const Text('画像を後で設定しますか？'));
                                    })
                                : await model.addImage();
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => const MainPage(
                                          currenttab: 0,
                                        ),
                                    transitionDuration:
                                        const Duration(seconds: 0)));
                          },
                          child: SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(
                              child: Text(
                                model.imageFile == null ? '後で設定する' : '次に進む',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF00BAFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}