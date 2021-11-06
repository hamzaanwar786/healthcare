import 'package:flutter/material.dart';
import 'package:healthcare/constants/constants.dart';

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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.35,
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/blue_back.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/mypic.png',
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
            // Container(
            //   width: size.width,
            //   height: size.height % 20,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("assets/images/blue_back.jpg"),
            //         fit: BoxFit.cover),
            //   ),
            //   child: Text("hello"),
            // ),
          ],
        ),
      )),
    );
  }
}
