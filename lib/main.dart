import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthcare/screens/appointment_doctors.dart';
import 'package:healthcare/screens/doctors_profile.dart';
import 'package:healthcare/screens/homepage.dart';
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
      home: DoctorsProfile(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => BottomNavigationView(),
      //   AppointmentDoctors.routename: (ctx) => AppointmentDoctors(),
      // },
    );
  }
}
