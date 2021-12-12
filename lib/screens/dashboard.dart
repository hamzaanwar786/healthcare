import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/screens/welfare.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/constants/constants.dart';
import 'package:healthcare/firebase/database.dart';
import '../models/doctors_model.dart';
import '../screens/hospitals.dart';
import '../screens/my_appointments.dart';
import '../screens/my_lab_test_bookings.dart';
import '../screens/order_medicine.dart';
import '../screens/start.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;
  String? _name, _phone_no, _email;
  List<Doctors> docList = [];
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
    user = await _auth.currentUser;

    if (user != null) {
      setState(() {
        this.user = user;
        this.isloggedin = true;
        // database!.initilize();
      });
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Stream<QuerySnapshot> _doctors =
      FirebaseFirestore.instance.collection('doctors').snapshots();

  singout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeBar = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: !isloggedin
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   child: ,
                    // ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/mypic.png'),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome ' + user!.displayName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )),

                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.bookMedical),
                                Text(
                                  'Appoinment',
                                  style: kStyle,
                                ),
                                Text(
                                  'Doctors appointment',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return MyAppointments();
                          },
                        ));
                      },
                    ),
                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.clinicMedical),
                                Text(
                                  'Lab Test',
                                  style: kStyle,
                                ),
                                Text(
                                  'Lab Test Booking',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return MyLabTestBookings();
                          },
                        ));
                      },
                    ),
                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mediation),
                                Text(
                                  'Order Medicine',
                                  style: kStyle,
                                ),
                                Text(
                                  'Order your medicine online',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return OrderMedicine();
                          },
                        ));
                      },
                    ),
                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.local_hospital_rounded),
                                Text(
                                  'Hospitals',
                                  style: kStyle,
                                ),
                                Text(
                                  'List of hospitals',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Hospitals.routename);
                      },
                    ),
                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.ambulance),
                                Text(
                                  'Ambulance',
                                  style: kStyle,
                                ),
                                Text(
                                  'Book Ambulance directly',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _makePhoneCall('tel:1122');
                        });
                      },
                    ),
                    RawMaterialButton(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.ambulance),
                                Text(
                                  'Welfare',
                                  style: kStyle,
                                ),
                                Text(
                                  'Contact with welfare socities',
                                ),
                              ],
                            ),
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return Welfare();
                          },
                        ));
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
