import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/doctors_model.dart';

class DoctorsProfile extends StatefulWidget {
  static const routename = '/doctors_profile';

  @override
  _DoctorsProfileState createState() => _DoctorsProfileState();
}

class _DoctorsProfileState extends State<DoctorsProfile> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Doctors;
    final size = MediaQuery.of(context).size;
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
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              // height: size.height * 0.35,
              padding: EdgeInsets.all(40),
              /* decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover),
                ),*/
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/mypic.png',
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.field,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Study',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.study,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Fee',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.fee,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Days',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.days,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Experince',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${data.experince} years',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Time',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.time,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Hospitals',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.hospitals,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),)
                ),
              ),
              )*/