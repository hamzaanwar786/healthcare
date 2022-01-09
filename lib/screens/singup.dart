import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import './bottomnavigationview.dart';
import './homepage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? _email, _password, _name;
  User? user;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavigationView()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // this.checkAuthentification();
  }

  sign_Up() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
        if (userCredential != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
        }
      } on FirebaseAuthException catch (e) {
        showError(e.code);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'TTNorms',
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/registerimage.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Name',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'TTNorms',
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _name = input!,
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter email!';
                          },
                        ),
                      ),
                      Container(
                        width: size.width * 1,
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
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
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Password',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily: 'TTNorms',
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input!,
                          )),
                      Container(
                        width: size.width * 1,
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: sign_Up,
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
                            shadowColor:
                                MaterialStateProperty.all(Colors.black),
                            elevation: MaterialStateProperty.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
