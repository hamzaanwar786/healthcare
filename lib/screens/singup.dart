import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/bottomnavigationview.dart';
import '../screens/homepage.dart';

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
    this.checkAuthentification();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Image.asset(
                  'assets/images/registerimage.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.perm_identity),
                            hintText: 'Write your name',
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => _name = input!,
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter email!';
                          },
                        ),
                      ),
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
                        onPressed: sign_Up,
                        child: Text(
                          'Register',
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
