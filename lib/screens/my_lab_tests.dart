import 'dart:convert';

import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/constants.dart';

class MyLabTests extends StatefulWidget {
  const MyLabTests({Key? key}) : super(key: key);

  @override
  _MyLabTestsState createState() => _MyLabTestsState();
}

class _MyLabTestsState extends State<MyLabTests> {
  var testId;
  var labId;
  var locId;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final Stream<QuerySnapshot> _labs =
      FirebaseFirestore.instance.collection('labs').snapshots();

  final Stream<QuerySnapshot> _tests =
      FirebaseFirestore.instance.collection('tests').snapshots();

  get isKeyboard => MediaQuery.of(context).viewInsets.bottom != 0;

  String selectHos = 'Blood Test';

  String? _labName,
      _testName,
      _date,
      _location,
      _name,
      _phone,
      _time,
      _price = '0';
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('labtestbooking');

  Future<void> addLabTextBooking() {
    // Call the user's CollectionReference to add a new user
    return collectionReference.doc(FirebaseAuth.instance.currentUser.uid).set({
      'lab': _labName,
      'tests': _testName,
      'date': _date,
      'location': _location,
      'name': _name,
      'phone': _phone,
      'price': _price,
    }).then((value) {
      print("Medicine Added");
      Navigator.of(context).pop();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  void _testDropItemSelected(var newValueSelected) {
    setState(() {
      this.testId = newValueSelected;

      LineSplitter lineSplitter = new LineSplitter();
      List<String> lines = lineSplitter.convert(testId!);
      for (var i = 0; i < lines.length; i++) {
        print('Line $i: ${lines[i]}');
        if (i == 0) {
          _testName = lines[i];
        } else {
          _setPrice(lines[i]);
        }
      }

      // _testName = testId;
      print(testId);
    });
  }

  void _labDropItemSelected(var newValueSelected) {
    setState(() {
      this.labId = newValueSelected;
      _labName = labId;
      print(labId);
    });
  }

  void _locDropItemSelected(var newValueSelected) {
    setState(() {
      this.locId = newValueSelected;
      _location = locId;
      print(locId);
    });
  }

  _setPrice(String price) {
    setState(() {
      this._price = price;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        _date =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        _time = '${selectedTime.hour} : ${selectedTime.minute}';
        print(_time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10.0),
                    child: Text(
                      'Lab Test Booking'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                new StreamBuilder<QuerySnapshot>(
                    stream: _labs,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blue.shade50,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                hint: const Text(
                                  'Choose Your Lab        ',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                iconEnabledColor: Colors.blueAccent,
                                value: labId,
                                isDense: false,
                                elevation: 100,
                                dropdownColor: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(20.0),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                                //alignment: Alignment.centerLeft,
                                items: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()!;
                                  return DropdownMenuItem<String>(
                                    value: data['name'],
                                    child: Text(
                                      data['name'],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (valueselectedbyUser) {
                                  _labDropItemSelected(valueselectedbyUser);
                                }),
                          ));
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.blue.shade50,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: const Text(
                            'Choose Your Location        ',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          iconEnabledColor: Colors.blueAccent,
                          value: locId,
                          isDense: false,
                          elevation: 100,
                          dropdownColor: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20.0),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                          ),
                          //alignment: Alignment.centerLeft,
                          items: [
                            DropdownMenuItem(
                              value: 'Lahore',
                              child: Text('Lahore'),
                            ),
                            DropdownMenuItem(
                              value: 'Islamabad',
                              child: Text('Islamabad'),
                            ),
                            DropdownMenuItem(
                              value: 'Karachi',
                              child: Text('Karachi'),
                            ),
                            DropdownMenuItem(
                              value: 'Faisalabad',
                              child: Text('Faisalabad'),
                            ),
                          ],
                          onChanged: (valueselectedbyUser) {
                            _locDropItemSelected(valueselectedbyUser);
                          }),
                    )),
                SizedBox(
                  height: 20,
                ),
                new StreamBuilder<QuerySnapshot>(
                    stream: _tests,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blue.shade50,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                hint: const Text(
                                  'Choose Your Test        ',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                iconEnabledColor: Colors.blueAccent,
                                value: testId,
                                isDense: false,
                                elevation: 100,
                                dropdownColor: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(20.0),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                                //alignment: Alignment.centerLeft,
                                items: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data()!;
                                  // _setPrice(data['price']);
                                  return DropdownMenuItem<String>(
                                      value:
                                          data['name'] + '\n' + data['price'],
                                      child: Text(
                                        data['name'],
                                        // key: testId,
                                      ));
                                }).toList(),
                                onChanged: (valueselectedbyUser) {
                                  _testDropItemSelected(valueselectedbyUser);
                                }),
                          ));
                    }),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Date'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          FontAwesomeIcons.calendarWeek,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10.0),
                    child: Text(
                      'Address Detail'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                    onChanged: (input) => _name = input,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Contact Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                    onChanged: (input) => _phone = input,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(_price.toString()),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 90.0),
                  color: Colors.blue.shade100,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red)
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        MessageDialog messageDialog = MessageDialog(
                          dialogBackgroundColor: Colors.white,
                          buttonOkColor: Colors.blue,
                          title: 'Your Total Bill',
                          titleColor: Colors.black,
                          message: _price.toString(),
                          messageColor: Colors.black,
                          buttonOkText: 'Ok',
                          dialogRadius: 20.0,
                          buttonRadius: 15.0,
                        );
                        messageDialog.show(
                          context,
                          barrierColor: Colors.white,
                        );
                        addLabTextBooking();
                      });
                      print('total bill');
                    },
                    child: const Text(
                      'Total Bill',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
