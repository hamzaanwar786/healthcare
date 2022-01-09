import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './dashboard.dart';
import './start.dart';
import './homepage.dart';
import './profile.dart';

class BottomNavigationView extends StatefulWidget {
  static const routename = 'bottom_navigation_view';

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
// Firebase Start
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User? user = await _auth.currentUser;
    await user.reload();
    // user = await _auth.currentUser;

    if (user != null) {
      setState(() {
        this.user = user;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  int currentIndex = 0;

  final screens = [Dashboard(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ('Profile')),
        ],
      ),
    );
  }
}
