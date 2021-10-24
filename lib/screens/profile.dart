import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Card(
            child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'assets/images/personicon.png',
                  height: 20,
                  width: 20,
                )),
            elevation: 4.0,
          ),
          SizedBox(
            height: 40,
          ),
          Card(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('email', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('number', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
