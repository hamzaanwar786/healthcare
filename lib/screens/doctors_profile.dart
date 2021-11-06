import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorsProfile extends StatefulWidget {
  const DoctorsProfile({Key? key}) : super(key: key);

  @override
  _DoctorsProfileState createState() => _DoctorsProfileState();
}

class _DoctorsProfileState extends State<DoctorsProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                    'images/mypic.png',
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Name',
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('About Doctor',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          wordSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Family Medicine Experience delivered inspiring solutions designed to improve patient care practice.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Form(

                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Location',
                                  icon: Icon(Icons.location_on),
                                  hintText: 'Your Location',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (input) {
                                  if (input!.isEmpty) return 'Enter location!';
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'City',
                                  icon: Icon(Icons.location_city),
                                  hintText: 'Your city address',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (input) {
                                  if (input!.isEmpty) return 'Enter email!';
                                },
                              ),
                            ),

                          ],
                        ),
                      ),






                    ],
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