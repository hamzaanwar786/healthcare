import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare/constants/constants.dart';
import 'package:healthcare/firebase/database.dart';
import 'package:healthcare/screens/appointment_doctors.dart';
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
                                return AppointmentDoctors();
                              },
                            ));
                          },
                        ),
                        Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                              width: 185,
                              height: 154,
                              child: Card(
                                color: Color(0xFF7165D6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                elevation: 15,
                                child: Column(
                                  children: [
                                    RawMaterialButton(
                                      hoverColor: Colors.blueGrey,
                                      elevation: 0.0,
                                      child: const Icon(
                                        FontAwesomeIcons.plus,
                                        size: 30,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute<void>(
                                        //   builder: (BuildContext context) {
                                        //     return PatientInfo();
                                        //   },
                                        // ));
                                        print('Patient Info');
                                      },
                                      constraints:
                                          const BoxConstraints.tightFor(
                                        width: 56.0,
                                        height: 56.0,
                                      ),
                                      shape: CircleBorder(),
                                      fillColor: Color(0xFFFFFFFF),
                                    ),
                                    const Text(
                                      'Clinic Visit',
                                      style: kStyle,
                                    ),
                                    Text('Make an Appointment'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 180,
                          height: 154,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            elevation: 15,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.plus),
                                ),
                                Text(
                                  'Clinic Visit',
                                  style: kStyle,
                                ),
                                Text('Make an Appointment'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 154,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            elevation: 15,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.plus),
                                ),
                                Text(
                                  'Clinic Visit',
                                  style: kStyle,
                                ),
                                Text('Make an Appointment'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 154,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            elevation: 15,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.plus),
                                ),
                                Text(
                                  'Clinic Visit',
                                  style: kStyle,
                                ),
                                Text('Make an Appointment'),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          height: 154,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            elevation: 15,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.plus),
                                ),
                                sizebox1,
                                Text(
                                  'Clinic Visit',
                                  style: kStyle,
                                ),
                                sizebox2,
                                Text('Make an Appointment'),
                              ],
                            ),
                          ),
                        ),
                      ],
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
