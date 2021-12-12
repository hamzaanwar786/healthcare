import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/bottomnavigationview.dart';

class SplashScreen extends StatefulWidget {
  static const routename = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigationView())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Text(
              'HealthCare',
              style: TextStyle(
                  fontSize: 50, color: Theme.of(context).primaryColor),
            ),
          )),
    );
  }
}
