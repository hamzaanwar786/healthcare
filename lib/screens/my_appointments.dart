import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/constants/constants.dart';
import 'package:healthcare/screens/appointment_doctors.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection('appointments')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Text('Order Medicine'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Appoinments',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0XFF302F33),
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return AppointmentDoctors();
                              },
                            ));
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new StreamBuilder<DocumentSnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                if (snapshot.data!.exists) {
                  var userDocument = snapshot.data;
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userDocument!['doctor'],
                              style: kStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userDocument['hospital'],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userDocument['date'],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userDocument['time'],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userDocument['location'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    elevation: 4.0,
                  );
                  // return Expanded(
                  //   child: ListView(
                  //     children: snapshot.data!.docs
                  //         .map((DocumentSnapshot document) {
                  //       Map<String, dynamic> data =
                  //           document.data()! as Map<String, dynamic>;
                  //       return Card(
                  //         child: Container(
                  //           padding: EdgeInsets.all(20.0),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   data['doctor'],
                  //                   style: kStyle,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   data['hospital'],
                  //                 ),
                  //               ),
                  //               Container(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   data['date'],
                  //                 ),
                  //               ),
                  //               Container(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   data['time'],
                  //                 ),
                  //               ),
                  //               Container(
                  //                 alignment: Alignment.topLeft,
                  //                 child: Text(
                  //                   data['location'],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         elevation: 4.0,
                  //       );
                  //     }).toList(),
                  //   ),
                  // );
                } else
                  return Center(child: Text('Nothing in the List'));
              }),
        ],
      ),
    );
  }
}
