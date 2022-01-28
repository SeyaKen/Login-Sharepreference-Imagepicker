import 'package:flutter/material.dart';
import 'package:machupichu/SignIn/signout.dart';
import 'package:machupichu/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.currenttab}) : super(key: key);
  final int currenttab;

  @override
  State<MainPage> createState() => _MainPageState(currenttab);
}

class _MainPageState extends State<MainPage> {
  int currenttab;
  _MainPageState(this.currenttab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currenttab = index;
            });
          },
          currentIndex: currenttab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey.withOpacity(0.7),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 17,
                child: Icon(
                  Icons.home_filled,
                  size: 33,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 17,
                child: Icon(
                  Icons.email_rounded,
                  size: 33,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 17,
                child: Icon(
                  Icons.account_circle,
                  size: 33,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: const [
          HomePage(),
          Signout(),
          HomePage(),
        ],
        index: currenttab,
      ),
    );
  }
}