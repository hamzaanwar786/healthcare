import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcare/firebase/database.dart';
import 'package:healthcare/screens/my_appointments.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentDoctors extends StatefulWidget {
  const AppointmentDoctors({Key? key}) : super(key: key);

  @override
  _AppointmentDoctorsState createState() => _AppointmentDoctorsState();
}

class _AppointmentDoctorsState extends State<AppointmentDoctors> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isId = false;
  var d_id = null;
  var hospitalId;
  var doctorId;
  Database? database;
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? _name,
      _location,
      _description,
      _hospital_name,
      _doctor_name,
      _date,
      _time,
      _pastmed;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addApointment() {
    // Call the user's CollectionReference to add a new user
    return collectionReference.doc(FirebaseAuth.instance.currentUser.uid).set({
      'name': _name,
      'location': _location,
      'hospital': _hospital_name,
      'doctor': _doctor_name,
      'date': _date,
      'time': _time,
      'past_med': _pastmed,
    }).then((value) {
      print("User Added");
      Navigator.of(context).pop();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
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

  final Stream<QuerySnapshot> _hospitals =
      FirebaseFirestore.instance.collection('hospitals').snapshots();
  late final Stream<QuerySnapshot> _doc;

  void _onhospitalDropItemSelected(var newValueSelected) {
    setState(() {
      this.hospitalId = newValueSelected;
      // _hospital_name = hospitalId;
      LineSplitter lineSplitter = new LineSplitter();
      List<String> lines = lineSplitter.convert(hospitalId!);
      for (var i = 0; i < lines.length; i++) {
        print('Line $i: ${lines[i]}');
        if (i == 0) {
          _hospital_name = lines[i];
        } else {
          _setDoc(lines[i]);
        }
      }
      print(hospitalId);
    });
  }

  _setDoc(String did) {
    setState(() {
      this.d_id = did;
      isId = true;
      _doc = FirebaseFirestore.instance
          .collection('hospitals/' + d_id + '/doc_onboard')
          .snapshots();
    });
  }

  void _ondoctorDropItemSelected(var newValueSelected) {
    setState(() {
      this.doctorId = newValueSelected;
      _doctor_name = doctorId;
      print(doctorId);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Text('Order Medicine'),
      ),
      backgroundColor: Color(0XFFFFFFFF),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Patient Information',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0XFF302F33),
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new StreamBuilder<QuerySnapshot>(
                  stream: _hospitals,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: TextStyle(color: Colors.blue),
                          iconEnabledColor: Colors.black,
                          value: hospitalId,
                          isDense: false,
                          onChanged: (valueselectedbyUser) {
                            _onhospitalDropItemSelected(valueselectedbyUser);
                          },
                          items: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()!;
                            return DropdownMenuItem<String>(
                              value: data['name'] + '\n' + data['id'],
                              child: Text(
                                data['name'],
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Please choose a hospital",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  }),
              !isId
                  ? SizedBox(
                      height: 20,
                    )
                  : new StreamBuilder<QuerySnapshot>(
                      stream: _doc,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              style: TextStyle(color: Colors.blue),
                              iconEnabledColor: Colors.black,
                              value: doctorId,
                              isDense: false,
                              onChanged: (valueselectedbyUser) {
                                _ondoctorDropItemSelected(valueselectedbyUser);
                              },
                              items: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()!;
                                return DropdownMenuItem<String>(
                                  value: data['name'] + ' ' + data['field'],
                                  child: Text(
                                    data['name'] + ' ' + data['field'],
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Please choose a doctor",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      }),
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
                  child: _date == null
                      ? Text("Select Date")
                      : Text(_date.toString()),
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
                    _selectTime(context);
                  },
                  child: _time == null
                      ? Text("Select Time")
                      : Text(_time.toString()),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: TextField(
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.person),
                      hintText: 'Enter your name'),
                  keyboardType: TextInputType.text,
                  onChanged: (input) => _name = input,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Location',
                        icon: Icon(Icons.location_city),
                        hintText: 'Enter your location'),
                    keyboardType: TextInputType.text,
                    onChanged: (input) => _location = input,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        icon: Icon(Icons.description),
                        hintText: 'Enter description'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onChanged: (input) => _description = input,
                  ),
                  // ends the actual text box
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'Any medicine in past',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: !isChecked
                    ? null
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3, //grow automatically
                          decoration: InputDecoration(
                            hintText: 'Name and Description of medicine',
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                          ),
                          onChanged: (input) => _pastmed = input,
                        ),
                        // ends the actual text box
                      ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    onPressed: () {
                      // setState(() {
                      //   // MessageDialog messageDialog = MessageDialog(
                      //   //   dialogBackgroundColor: Colors.white,
                      //   //   buttonOkColor: Colors.blue,
                      //   //   title: 'Appoinment',
                      //   //   titleColor: Colors.black,
                      //   //   message: 'has been booked',
                      //   //   messageColor: Colors.black,
                      //   //   buttonOkText: 'Ok',
                      //   //   dialogRadius: 20.0,
                      //   //   buttonRadius: 15.0,
                      //   //   buttonOkOnPressed: () {
                      //   //     Navigator.pop(context);
                      //   //   },
                      //   // );
                      //   // messageDialog.show(
                      //   //   context,
                      //   //   barrierColor: Colors.white,
                      //   // );
                      if (_hospital_name == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please choose a hospital')));
                      } else if (_doctor_name == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please choose a doctor')));
                      } else if (_date == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please choose a date')));
                      } else if (_time == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please choose a time')));
                      } else if (_name == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter your name')));
                      } else if (_location == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter your location')));
                      } else if (_description == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please enter your description')));
                      } else {
                        Navigator.of(context).pop();
                        addApointment();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Appointment Fixed')));
                      }
                      // if (_formKey.currentState!.validate()) {
                      //   addApointment();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(content: Text('Medicine Ordered')));
                      // }
                      // });
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // });
  }
}
