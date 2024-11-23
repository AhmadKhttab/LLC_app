import 'dart:ffi';
import 'package:LLC/custom/field2.dart';
import 'package:flutter/material.dart';
import 'signup2.dart'; // افترض أن هذا هو ملف الصفحة الثانية

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _SignupState();
}

GlobalKey<FormState> formkey = GlobalKey();
TextEditingController namear = TextEditingController();
TextEditingController fatherar = TextEditingController();
TextEditingController surnamear = TextEditingController();
TextEditingController mothear = TextEditingController();
TextEditingController nameen = TextEditingController();
TextEditingController fatheren = TextEditingController();
TextEditingController surnameen = TextEditingController();
TextEditingController motheen = TextEditingController();
TextEditingController gender = TextEditingController();
TextEditingController place = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController national = TextEditingController();

class _SignupState extends State<signup> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        date.text = "${_selectedDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('hello');
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              child: Image.asset("images/logo-dark.png"),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0XFFA18F5A),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(
                      color: Color(0xFF65598F),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                  const Divider(
                    color: Color(0XFFA18F5A),
                    thickness: 2,
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Text('( '),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(' )'),
                      SizedBox(width: 10),
                      Text('Field is required'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextField2(
                    labelText: 'First Name (AR)*',
                    controller: namear,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Father Name (AR)*',
                    controller: fatherar,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Surname (AR)*',
                    controller: surnamear,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Mother Name (AR)*',
                    controller: mothear,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'First Name (EN)*',
                    controller: nameen,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Father Name (EN)*',
                    controller: fatheren,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Surname (EN)*',
                    controller: surnameen,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Mother Name (EN)*',
                    controller: motheen,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: InputDecoration(labelText: 'Gender*'),
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        gender.text = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a gender";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Place of birth*',
                    controller: place,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Date of birth*',
                    readonly: true,
                    ontap: () => _selectDate(context),
                    controller: date,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  CustomTextField2(
                    labelText: 'National Number*',
                    controller: national,
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      height: 50,
                      minWidth: 90,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => signup2(
                                namear: namear.text,
                                fatherar: fatherar.text,
                                surnamear: surnamear.text,
                                mothear: mothear.text,
                                nameen: nameen.text,
                                fatheren: fatheren.text,
                                surnameen: surnameen.text,
                                motheen: motheen.text,
                                gender: gender.text,
                                place: place.text,
                                date: date.text,
                                national: national.text,
                              ),
                            ),
                          );
                        }
                      },
                      color: Color(0xFF65598F),
                      child: const Icon(
                        Icons.arrow_circle_right,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
