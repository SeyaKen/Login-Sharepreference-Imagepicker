import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machupichu/home/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool like = false;
  bool likecolor = false;
  Stream<QuerySnapshot<Object?>>? homeListsStream;
  bool _isLoading = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final ScrollController _scrollController = ScrollController();
  int _currentMax = 100;

  // getHomeLists() async {
  //   homeListsStream = await HomeListModel(uid).fetchImages(100);
  //   setState(() {});
  //   // setStateがよばれるたびにrebuildされる
  // }

  // onScreenLoaded() async {
  //   getHomeLists();
  // }

  // _getMoreData() async {
  //   _currentMax = _currentMax + 100;
  //   print(_currentMax);
  //   homeListsStream = await HomeListModel(uid).fetchImages(_currentMax);
  //   // UIを読み込み直す
  //   setState(() {});
  // }

  @override
  void initState() {
    // onScreenLoaded();
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      setState(() {
        _isLoading = false;
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _getMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.height * 0.693,
                            child: GridView.count(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              crossAxisCount: 6,
                              childAspectRatio: 0.6,
                              children: List.generate(6, (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                  child: Text(
                                      index.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                );
                              }),
                            )),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: GridView.count(
                                controller: _scrollController,
                                crossAxisCount: 6,
                                childAspectRatio: 0.6,
                                children: List.generate(36, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
