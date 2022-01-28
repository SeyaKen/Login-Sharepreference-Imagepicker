import 'package:cloud_firestore/cloud_firestore.dart';

class HomeListModel {
  final String uid;
  HomeListModel(this.uid);

  Future<Stream<QuerySnapshot>> fetchImages(int suuji) async {
    return FirebaseFirestore.instance.collection('posts').limit(suuji).snapshots();
  }
}