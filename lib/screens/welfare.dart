import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';

class Welfare extends StatefulWidget {
  const Welfare({Key? key}) : super(key: key);

  @override
  State<Welfare> createState() => _WelfareState();
}

class _WelfareState extends State<Welfare> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/mypic.png')),
                                sizebox1,
                                Text(
                                  'Edhi Welfare',
                                  style: kStyle,
                                ),
                                sizebox2,
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _makePhoneCall('tel:03001111111');
                                      });
                                    },
                                    icon: Icon(Icons.phone)),
                              ],
                            ),
                          ])),
                ),
              ),
              Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/mypic.png')),
                                sizebox1,
                                Text(
                                  'Edhi Welfare',
                                  style: kStyle,
                                ),
                                sizebox2,
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _makePhoneCall('tel:03001111111');
                                      });
                                    },
                                    icon: Icon(Icons.phone)),
                              ],
                            ),
                          ])),
                ),
              ),
              Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/mypic.png')),
                                sizebox1,
                                Text(
                                  'Edhi Welfare',
                                  style: kStyle,
                                ),
                                sizebox2,
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _makePhoneCall('tel:03001111111');
                                      });
                                    },
                                    icon: Icon(Icons.phone)),
                              ],
                            ),
                          ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
