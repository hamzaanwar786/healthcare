import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/constants/constants.dart';
import 'package:healthcare/screens/my_lab_tests.dart';

class MyLabTestBookings extends StatefulWidget {
  const MyLabTestBookings({Key? key}) : super(key: key);

  @override
  _MyLabTestBookingsState createState() => _MyLabTestBookingsState();
}

class _MyLabTestBookingsState extends State<MyLabTestBookings> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('labtestbooking').snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        'Lab Test',
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
                                  return MyLabTests();
                                },
                              ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['lab'],
                                      style: kStyle,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['tests'],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['date'],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['location'],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['name'],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['price'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            elevation: 4.0,
                          );
                        }).toList(),
                      ),
                    );
                  } else
                    return Text('Nothing in the List');
                }),
          ],
        ),
      ),
    );
  }
}
