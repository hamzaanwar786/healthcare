import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase/database.dart';
import 'package:healthcare/screens/start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloggedin = false;
  String? _name, _phone_no, _email;
  Database? database;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': user!.displayName, // John Doe
          'email': user!.email, // Stokes and Sons
          'phone_no': _phone_no // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<void> addUser(String name, String email, String phone_no) async {
  //   CollectionReference collectionReference =
  //       await database!.firebaseFirestore!.collection('users');
  //   return collectionReference
  //       .add({"name": name, "email": email, "phone_no": phone_no})
  //       .then((value) => print("User Added Successfully"))
  //       .catchError((onError) => print("failed to add user : $onError"));
  // }

  getUser() async {
    User? user = await _auth.currentUser;
    await user.reload();
    user = await _auth.currentUser;

    if (user != null) {
      setState(() {
        this.user = user;
        this.isloggedin = true;
        // database!.initilize();
      });
    }
  }

  singout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 400,
                      child: Image.asset(
                        'assets/images/welcomeimage.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(user!.displayName),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: "Phone No#",
                                icon: Icon(Icons.phone),
                                hintText: "000 0000 0000"),
                            keyboardType: TextInputType.number,
                            onChanged: (input) => _phone_no = input,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Hello ${user?.displayName} you are Logged in as ${user?.email}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: addUser,
                      child: Text(
                        'Add Information',
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
                    ElevatedButton(
                      onPressed: singout,
                      child: Text(
                        'Signout',
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
      ),
    );
  }
}
