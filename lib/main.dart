import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthcare/screens/splash_screen.dart';

import './screens/doctors_profile.dart';
import './screens/homepage.dart';
import './screens/hospitals.dart';
import './screens/hospitals_details.dart';
import './screens/my_appointments.dart';
import './screens/bottomnavigationview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      debugShowCheckedModeBanner: false,

      // home: MyAppointments(),
      // home: DoctorsProfile(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        BottomNavigationView.routename: (ctx) => BottomNavigationView(),
        Hospitals.routename: (ctx) => Hospitals(),
        HospitalsDetails.routename: (ctx) => HospitalsDetails(),
        DoctorsProfile.routename: (ctx) => DoctorsProfile(),
      },
    );
  }
}
