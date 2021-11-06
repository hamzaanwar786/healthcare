import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/constants/constants.dart';
import 'package:healthcare/firebase/database.dart';
import 'package:healthcare/models/doctors_model.dart';
import 'package:healthcare/screens/appointment_doctors.dart';
import 'package:healthcare/screens/my_appointments.dart';
import 'package:healthcare/screens/my_lab_test_bookings.dart';
import 'package:healthcare/screens/my_lab_tests.dart';
import 'package:healthcare/screens/order_medicine.dart';
import 'package:healthcare/screens/start.dart';

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
    return SafeArea(
      maintainBottomViewPadding: true,
      child: !isloggedin
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user!.displayName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0XFF302F33),
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0),
                              child: Icon(
                                Icons.accessibility,
                                size: 50,
                                color: Color(0XFFFECD47),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png'),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RawMaterialButton(
                            child: Card(
                              margin: EdgeInsets.only(left: 10),
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.plus),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return MyAppointments();
                                },
                              ));
                            },
                          ),
                          RawMaterialButton(
                            child: Card(
                              margin: EdgeInsets.only(left: 10),
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.plus),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return MyLabTestBookings();
                                },
                              ));
                            },
                          ),
                          RawMaterialButton(
                            child: Card(
                              margin: EdgeInsets.only(left: 10),
                              child: Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.plus),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return OrderMedicine();
                                },
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  //gfchbjkljuyhtfrgyhujikl;
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Row(
                      children: const [
                        Text(
                          'Popular Doctors',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*fghjmjfiuygbuifiuh
            * uinjdfkvn kld
            * focx;l.
            * njfkdlcxm
            * vndfjkcxm
            * nvfdkl*/

                  new StreamBuilder<QuerySnapshot>(
                      stream: _doctors,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return new Text(
                              'Error in receiving trip photos: ${snapshot.error}');
                        }

                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return new Text(
                                'Not connected to the Stream or null');

                          case ConnectionState.waiting:
                            return new Text('Awaiting for interaction');

                          case ConnectionState.active:
                            print("Stream has started but not finished");

                            var totalPhotosCount = 0;
                            List<DocumentSnapshot> tripPhotos;

                            if (snapshot.hasData) {
                              tripPhotos = snapshot.data!.docs;
                              totalPhotosCount = tripPhotos.length;

                              if (totalPhotosCount > 0) {
                                return new GridView.builder(
                                    itemCount: totalPhotosCount,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: Card(
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 180,
                                              height: 188,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 30,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/images/mypic.png')),
                                                        sizebox1,
                                                        Text(
                                                          tripPhotos[index]
                                                              ['name'],
                                                          style: kStyle,
                                                        ),
                                                        sizebox2,
                                                        Text(tripPhotos[index]
                                                            ['field']),
                                                      ],
                                                    ),
                                                  ])),
                                        ),
                                      );
                                    });
                              }
                            }

                            return new Center(
                                child: Column(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                ),
                                new Text(
                                  "No trip photos found.",
                                  style: kStyle,
                                )
                              ],
                            ));

                          case ConnectionState.done:
                            return new Text('Streaming is done');
                        }
                      }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //rtfyguhijkol;
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 188,
                        child: Card(
                          color: Color(0XFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          elevation: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/mypic.png')),
                              sizebox1,
                              Text(
                                'Dr. Chris Frazier ',
                                style: kStyle,
                              ),
                              sizebox2,
                              Text('Pediatrician'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
