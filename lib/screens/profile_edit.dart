import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone_no;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
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
                      if (input!.isEmpty) return 'Enter Name!';
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'phone',
                      icon: Icon(Icons.perm_identity),
                      hintText: 'Write your name',
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (input) => _name = input!,
                    validator: (input) {
                      if (input!.isEmpty) return 'Enter Name!';
                    },
                  ),
                ),
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
                      if (input!.isEmpty) return 'Enter Name!';
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
