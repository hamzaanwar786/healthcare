import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderMedicine extends StatefulWidget {
  const OrderMedicine({Key? key}) : super(key: key);

  @override
  _OrderMedicineState createState() => _OrderMedicineState();
}

class _OrderMedicineState extends State<OrderMedicine> {
  final _formKey = GlobalKey<FormState>();
  late String _phone, _name, _address, _medicine;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('ordermedicine');

  Future<void> addApointment() {
    // Call the user's CollectionReference to add a new user
    return collectionReference.add({
      'phone': _phone,
      'name': _name,
      'address': _address,
      'medicine': _medicine,
    }).then((value) {
      print("Medicine Added");
      Navigator.of(context).pop();
      //  ScaffoldMessenger.of(context).showSnackBar(
      // const SnackBar(content: Text('Processing Data'));
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Order Medicine'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                                'Health Care will Take care of your health. So, that\'s why will dealiver your medicine at your doorstep')),
                        Expanded(
                            child: Image.asset(
                          'assets/images/mypic.png',
                          fit: BoxFit.cover,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Add TextFormFields and ElevatedButton here.
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Number',
                            icon: Icon(Icons.phone),
                            hintText: '+920000000000'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (input) => _phone = input,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.person),
                            hintText: 'Enter your name'),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (input) => _name = input,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Address',
                            icon: Icon(Icons.location_pin),
                            hintText: 'Enter your address'),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (input) => _address = input,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Medicine',
                            icon: Icon(Icons.medication),
                            hintText:
                                'Please wrtie your medicines..etc Panadol'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (input) => _medicine = input,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Medicine Ordered')),
                            );
                            addApointment();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
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
