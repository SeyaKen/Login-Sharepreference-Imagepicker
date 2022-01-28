import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machupichu/SignIn/sharedpref_helper.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService(this.uid);
  File? imageFile;
  String pictureURL = '';

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<Stream<QuerySnapshot>> fetchImage() async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future allUpload() async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'ex': '',
      'imageURL': pictureURL,
      'major':  await SharedPreferencesHelper().getMajorId(),
      'name':  await SharedPreferencesHelper().getNameId(),
    });
  }

  void updateUserName(String name) async {
    SharedPreferencesHelper().saveNameId(name);
  }

  void updateUserMajor(String major) async {
    SharedPreferencesHelper().saveMajorId(major);
  }

  void updateUserPicture(String pictureURL) async {
    this.pictureURL = pictureURL;
  }

  Future updateUserEx(String ex) async {
    await userCollection.doc(uid).update({
      'ex': ex,
    });
  }

  Future<QuerySnapshot> getUserInfo(String uid) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
  }

  Future showImagePicker() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      imageFile = File(pickedFile!.path);
      notifyListeners();
      return imageFile;
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  Future addImage() async {
    final pictureURL = await uploadFile();

    // firebaseに追加
    updateUserPicture(pictureURL);
    allUpload();
    SharedPreferencesHelper().saveUserId(uid);
    fetchImage();
  }

  // ファイルをアップロードする関数
  Future<String> uploadFile() async {
    if (imageFile == null) {
      return 'https://firebasestorage.googleapis.com/v0/b/machupichujikanwari.appspot.com/o/anonimous.png?alt=media&token=b651c48e-db26-47f1-9856-24943e1d38b1';
    } else {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('images').child(uid);

      final snapshot = await ref.putFile(
        imageFile!,
      );

      final urlDownload = await snapshot.ref.getDownloadURL();

      return urlDownload;
    }
  }
}
