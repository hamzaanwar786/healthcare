import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import './singup.dart';
import './login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigatetoLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  navigatetoRegister() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: size.height * 0.1),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'to Health Care',
                          style: TextStyle(
                              fontFamily: 'TTNorms',
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Find the medical facility at your home',
                            style: TextStyle(
                              fontFamily: 'TTNorms',
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/welcomeimage2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 1,
                      padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: navigatetoRegister,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.all(20.0),
                          ),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          elevation: MaterialStateProperty.all(10),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 1,
                      padding: EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: navigatetoLogin,
                        child: Text(
                          'I already have an account',
                          style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 20.0,
              // ),
              // SignInButton(
              //   Buttons.Google,
              //   text: "Sign up with Google",
              //   onPressed: () {},
              // )
            ],
          ),
        ),
      ),
    );
  }
}
