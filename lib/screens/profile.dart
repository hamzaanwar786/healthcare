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
          Card(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.person,
                size: 40.0,
              ),
            ),
            elevation: 4.0,
          )
        ],
      ),
    );
  }
}
