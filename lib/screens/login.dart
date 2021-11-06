import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Image.asset(
                  'assets/images/loginimage.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                            hintText: 'Your email address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _email = input!,
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter email!';
                          },
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.length < 6) {
                                return 'Provide minimum 6 character';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter minimum 6 character password',
                              icon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input!,
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: login,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
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
