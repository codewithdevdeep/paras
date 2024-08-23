import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({Key? key}) : super(key: key);

  @override
  _CreateTripState createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String? _selectedItem;

  List<String> _dropdownItems = [
    'Rohan',
    'Sohan',
    'mohan',
    'pummy',
    'sazam',
  ];
  String? _SelectedriverItem;

  List<String> _AssignItems = [
    'Ranchi',
    'Kolkota',
    'ramgarh',
    'banglore',
    'nagpur',
  ];

    String? _ToLOcation;

  List<String> _TolocationItems = [
     'Ranchi',
    'Kolkota',
    'ramgarh',
    'banglore',
    'nagpur',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 174, 243),
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Today's task",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.normal)))),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Trip Task",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    enabled: true,
                    validator: (value) {
                      if (value == "") {
                        return "please enter valid Trip Task";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        // hintText: 'Enter trip Task',
                        ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Select Date and Time",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == "") {
                      return "please enter valid Date and Time";
                    } else {
                      return null;
                    }
                  },
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    hintText: 'Click to select date',
                  ),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : '',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Asign Driver",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: _selectedItem,
                  validator: (value) {
                    if (value == null) {
                      return "please enter valid Driver";
                    } else {
                      return null;
                    }
                  },
                  items: _dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                  decoration: InputDecoration(
            
                      ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "From Location",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: _SelectedriverItem,
                  items: _AssignItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return "please enter valid location";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      _SelectedriverItem = value;
                    });
                  },
                  decoration: InputDecoration(),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "To Location",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: _ToLOcation,
                  validator: (value) {
                    if (_ToLOcation == null) {
                      return "please enter valid location";
                    } else {
                      return null;
                    }
                  },
                  items: _TolocationItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _ToLOcation = value;
                    });
                  },
                  decoration: InputDecoration(),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: "Total kilometer",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal)))),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    enabled: true,
                    validator: (value) {
                      if (value == "") {
                        return "please enter valid kilometer";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        // hintText: 'Enter trip Task',
                        ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
              ],
            ),
          ),
        ),
      ),
      /*floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          height: 55,
          width: Get.width,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 0, 174, 243))),
              onPressed: () {
                 if (_formKey.currentState!.validate()) {
                // Form is valid, perform your action here
                log('${_SelectedriverItem}');
                print('Form is valid');
              }else {
              print('form is not valid');
              }
              },
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Create Task",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontStyle: FontStyle.normal))))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
    );
  }
}
