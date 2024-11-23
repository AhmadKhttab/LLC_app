import 'package:LLC/custom/field2.dart';
import 'package:LLC/logs/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class signup2 extends StatefulWidget {
  // تعريف المتغيرات القادمة من الصفحة الأولى
  final String namear,
      fatherar,
      surnamear,
      mothear,
      nameen,
      fatheren,
      surnameen,
      motheen,
      gender,
      place,
      date,
      national;

  const signup2(
      {super.key,
      required this.namear,
      required this.fatherar,
      required this.surnamear,
      required this.mothear,
      required this.nameen,
      required this.fatheren,
      required this.surnameen,
      required this.motheen,
      required this.gender,
      required this.place,
      required this.date,
      required this.national});

  @override
  State<signup2> createState() => _Signup2State();
}

GlobalKey<FormState> formkey = GlobalKey();
TextEditingController nation = TextEditingController();
TextEditingController country = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController add = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController mobile = TextEditingController();
TextEditingController tele = TextEditingController();

class _Signup2State extends State<signup2> {
  String? selectedTelecenter;
  List<String> telecenters = []; // قائمة أسماء مراكز الاتصال

  @override
  void initState() {
    super.initState();
    fetchTelecenters(); // جلب مراكز الاتصال عند بدء التطبيق
  }

  // دالة لجلب البيانات من API
  Future<void> fetchTelecenters() async {
    final response = await http.get(
        // Uri.parse('http://82.137.217.211:1010/api.php?action=telecenters'),

        Uri.parse('http://82.137.217.211:1010/api.php?action=telecenters'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        telecenters = jsonResponse
            .map<String>((item) => item['Name_En'] as String)
            .toList();
      });
    } else {
      throw Exception('Failed to load Telecenters');
    }
  }

  // دالة إرسال البيانات عبر POST
  Future<void> submitData() async {
    final apiUrl =
        'http://82.137.217.211:1010/api.php?action=add_trainee'; // رابط API

    // بيانات المستخدم المراد إرسالها إلى الـ API
    final Map<String, String> userData = {
      'name_ar': widget.namear,
      'father_ar': widget.fatherar,
      'surname_ar': widget.surnamear,
      'mother_ar': widget.mothear,
      'name_en': widget.nameen,
      'father_en': widget.fatheren,
      'surname_en': widget.surnameen,
      'mother_en': widget.motheen,
      'gender': widget.gender,
      'place_of_birth': widget.place,
      'date_of_birth': widget.date,
      'nationality': nation.text,
      'country': country.text,
      'city': city.text,
      'address': add.text,
      'email': email.text,
      'phone': phone.text,
      'mobile': mobile.text,
      'telecenter': selectedTelecenter ?? '',
      'national number': national.text,
    };

    // إرسال البيانات عبر POST
    final response = await http.post(
      Uri.parse(apiUrl),
      body: userData,
    );

    if (response.statusCode == 200) {
      // عند نجاح الطلب، يمكنك إضافة عمليات أخرى مثل التنقل لصفحة أخرى أو عرض رسالة نجاح
      Navigator.of(context).pushNamedAndRemoveUntil('home', (routes) => false);
    } else {
      // عرض رسالة خطأ إذا لم ينجح الطلب
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to register. Please try again."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

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
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0XFFA18F5A))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF65598F),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      labelText: 'Nationality*',
                      controller: nation),
                  const SizedBox(height: 20),
                  CustomTextField2(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      labelText: 'Country*',
                      controller: country),
                  const SizedBox(height: 20),
                  CustomTextField2(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      labelText: 'City*',
                      controller: city),
                  const SizedBox(height: 20),
                  CustomTextField2(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      labelText: 'Address*',
                      controller: add),
                  const SizedBox(height: 20),
                  CustomTextField2(
                    labelText: 'Email*',
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address with "@" and ".com"';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField2(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Phone*',
                      controller: phone),
                  const SizedBox(height: 20),
                  CustomTextField2(
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " This Field is required";
                        }
                        return null;
                      },
                      labelText: 'Mobile*',
                      controller: mobile),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedTelecenter,
                    decoration: InputDecoration(labelText: 'Telecenter*'),
                    items: telecenters.map((String telecenter) {
                      return DropdownMenuItem<String>(
                        value: telecenter,
                        child: Text(telecenter),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTelecenter = newValue;
                        tele.text = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a Telecenter";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: MaterialButton(
                          color: Colors.grey[300],
                          height: 50,
                          minWidth: 90,
                          onPressed: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        child: MaterialButton(
                          height: 50,
                          minWidth: 90,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              submitData(); // إرسال البيانات عند التحقق من صحة المدخلات
                            }
                          },
                          color: Color(0xFF65598F),
                          child: const Icon(
                            Icons.telegram,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
