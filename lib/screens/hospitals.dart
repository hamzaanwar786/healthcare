import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';
import '../models/hospitals_model.dart';
import '../screens/hospitals_details.dart';

class Hospitals extends StatefulWidget {
  static const routename = '/hospitals';

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  final Stream<QuerySnapshot> _hospitals =
      FirebaseFirestore.instance.collection('hospitals').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          new StreamBuilder<QuerySnapshot>(
              stream: _hospitals,
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
                        return new ListView.builder(
                            itemCount: totalPhotosCount,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      HospitalsDetails.routename,
                                      arguments: HospitalsModel(
                                        id: tripPhotos[index]['id'],
                                        name: tripPhotos[index]['name'],
                                        address: tripPhotos[index]['address'],
                                        emergency: tripPhotos[index]
                                            ['emergency'],
                                        icu: tripPhotos[index]['icu'],
                                        availablity: tripPhotos[index]
                                            ['availablity'],
                                        doctoronboard: tripPhotos[index]
                                            ['doctoronboard'],
                                        ventilator: tripPhotos[index]
                                            ['ventilator'],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          height: 188,
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
                                                      style: kStyle,
                                                    ),
                                                    sizebox2,
                                                    Text(tripPhotos[index]
                                                        ['address']),
                                                  ],
                                                ),
                                              ])),
                                    ),
                                  ),
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
        ],
      )),
    );
  }
}
