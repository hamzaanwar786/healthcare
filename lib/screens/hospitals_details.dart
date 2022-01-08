import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';
import '../models/doctors_model.dart';
import '../models/hospitals_model.dart';
import '../screens/doctors_profile.dart';

class HospitalsDetails extends StatefulWidget {
  static const routename = '/hospitalsdetails';

  @override
  _HospitalsDetailsState createState() => _HospitalsDetailsState();
}

class _HospitalsDetailsState extends State<HospitalsDetails> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as HospitalsModel;
    final Stream<QuerySnapshot> _doc = FirebaseFirestore.instance
        .collection('hospitals/' + data.id + '/doc_onboard')
        .snapshots();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  text: "Doctors OnBoard",
                ),
                Tab(
                  icon: Icon(Icons.details),
                  text: "Hospital Detail",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Center(
              child: new StreamBuilder<QuerySnapshot>(
                  stream: _doc,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return new Text(
                          'Error in receiving trip photos: ${snapshot.error}');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return new Text('Not connected to the Stream or null');

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
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          DoctorsProfile.routename,
                                          arguments: Doctors(
                                              name: tripPhotos[index]['name'],
                                              field: tripPhotos[index]['field'],
                                              days: tripPhotos[index]['days'],
                                              experince: tripPhotos[index]
                                                  ['experince'],
                                              fee: tripPhotos[index]['fee'],
                                              hospitals: data.name,
                                              study: tripPhotos[index]['study'],
                                              time: tripPhotos[index]['time']),
                                        );
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(8),
                                          // padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            'assets/images/mypic.png')),
                                                    sizebox1,
                                                    Text(
                                                      tripPhotos[index]['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
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
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.local_hospital)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Name: ' + data.name),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.location_city)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Address: ' + data.address),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.medical_services)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  'Doctors on board: ' + data.doctoronboard),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.event_available)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Availablity: ' + data.availablity),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.warning)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Emergency: ' + data.emergency),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.medication)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('ICU: ' + data.icu),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.mediation_rounded)),
                        Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Ventilator: ' + data.ventilator),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // new StreamBuilder<QuerySnapshot>(
            //           stream: _doc,
            //           builder: (BuildContext context,
            //               AsyncSnapshot<QuerySnapshot> snapshot) {
            //             if (snapshot.hasError) {
            //               return new Text(
            //                   'Error in receiving trip photos: ${snapshot.error}');
            //             }

            //             switch (snapshot.connectionState) {
            //               case ConnectionState.none:
            //                 return new Text(
            //                     'Not connected to the Stream or null');

            //               case ConnectionState.waiting:
            //                 return new Text('Awaiting for interaction');

            //               case ConnectionState.active:
            //                 print("Stream has started but not finished");

            //                 var totalPhotosCount = 0;
            //                 List<DocumentSnapshot> tripPhotos;

            //                 if (snapshot.hasData) {
            //                   tripPhotos = snapshot.data!.docs;
            //                   totalPhotosCount = tripPhotos.length;

            //                   if (totalPhotosCount > 0) {
            //                     return new GridView.builder(
            //                         itemCount: totalPhotosCount,
            //                         scrollDirection: Axis.horizontal,
            //                         shrinkWrap: true,
            //                         primary: false,
            //                         gridDelegate:
            //                             new SliverGridDelegateWithFixedCrossAxisCount(
            //                                 crossAxisCount: 2),
            //                         itemBuilder:
            //                             (BuildContext context, int index) {
            //                           return Center(
            //                             child: GestureDetector(
            //                               onTap: () {
            //                                 Navigator.of(context).pushNamed(
            //                                   DoctorsProfile.routename,
            //                                   arguments: Doctors(
            //                                       name: tripPhotos[index]['name'],
            //                                       field: tripPhotos[index]
            //                                           ['field'],
            //                                       days: tripPhotos[index]['days'],
            //                                       experince: tripPhotos[index]
            //                                           ['experince'],
            //                                       fee: tripPhotos[index]['fee'],
            //                                       hospitals: tripPhotos[index]
            //                                           ['hospitals'],
            //                                       study: tripPhotos[index]
            //                                           ['study'],
            //                                       time: tripPhotos[index]
            //                                           ['time']),
            //                                 );
            //                               },
            //                               child: Card(
            //                                 child: Container(
            //                                     alignment: Alignment.center,
            //                                     width: 180,
            //                                     height: 188,
            //                                     child: Column(
            //                                         mainAxisSize:
            //                                             MainAxisSize.min,
            //                                         children: <Widget>[
            //                                           Column(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .center,
            //                                             children: [
            //                                               CircleAvatar(
            //                                                   radius: 30,
            //                                                   backgroundImage:
            //                                                       AssetImage(
            //                                                           'assets/images/mypic.png')),
            //                                               sizebox1,
            //                                               Text(
            //                                                 tripPhotos[index]
            //                                                     ['name'],
            //                                                 style: kStyle,
            //                                               ),
            //                                               sizebox2,
            //                                               Text(tripPhotos[index]
            //                                                   ['field']),
            //                                             ],
            //                                           ),
            //                                         ])),
            //                               ),
            //                             ),
            //                           );
            //                         });
            //                   }
            //                 }

            //                 return new Center(
            //                     child: Column(
            //                   children: <Widget>[
            //                     new Padding(
            //                       padding: const EdgeInsets.only(top: 50.0),
            //                     ),
            //                     new Text(
            //                       "No trip photos found.",
            //                       style: kStyle,
            //                     )
            //                   ],
            //                 ));

            //               case ConnectionState.done:
            //                 return new Text('Streaming is done');
            //             }
            //           }),
          ]),
        ));
  }
}
