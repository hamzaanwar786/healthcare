import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/screens/dashboard.dart';
import '../screens/homepage.dart';
import '../screens/bottomnavigationview.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigationView()));
      }
    });
    @override
    void initState() {
      super.initState();
      checkAuthentification();
    }
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        checkAuthentification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showError('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showError('Wrong password provided for that user.');
        } else {
          showError('' + e.code);
        }
      }
    }
  }

  showError(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 100),
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'TTNorms',
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              'Put your email and password to login',
                              style: TextStyle(
                                fontFamily: 'TTNorms',
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/welcomeimage.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   height: size.height * 0.,
              //   // child: Image.asset(
              //   //   'assets/images/loginimage.jpg',
              //   //   fit: BoxFit.contain,
              //   // ),

              // ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 1,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 100),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Email',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'TTNorms',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (input) => _email = input!,
                                  validator: (input) {
                                    if (input!.isEmpty) return 'Enter email!';
                                  },
                                ),
                              ),
                              Container(
                                  width: size.width * 1,
                                  margin: EdgeInsets.only(
                                      top: 8, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(240, 240, 240, 100),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (input) {
                                      if (input!.length < 6) {
                                        return 'Provide minimum 6 character';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'TTNorms',
                                    ),
                                    obscureText: true,
                                    onSaved: (input) => _password = input!,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 1,
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: login,
                            child: Text(
                              'Login',
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
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(10),
                            ),
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
      ),
    );
  }
}
