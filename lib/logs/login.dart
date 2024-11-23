/*import 'package:LLC/custom/button.dart';
import 'package:LLC/custom/textfiled.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController username = TextEditingController();
TextEditingController password =
    TextEditingController(); // Renamed for camelCase consistency
GlobalKey<FormState> form = GlobalKey();

class _LoginState extends State<Login> {
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
        key: form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            Container(
              child: Image.asset("images/logo-dark.png"),
            ),
            SizedBox(
              height: 100,
            ),
            CustomTextField(
              labelText: 'Username',
              icon: Icons.person,
              controller: username,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username must not be empty";
                }
                return null; // Added to return null when validation passes
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Password',
              icon: Icons.lock,
              controller: password,
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password must not be empty";
                } else if (value.length < 8) {
                  return "Password must be at least\n 8 characters long";
                }
                return null; // Added to return null when validation passes
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              color: Color(0xFF65598F),
              text: 'Sign in',
              onPressed: () {
                if (form.currentState!.validate()) {
                  Navigator.of(context).pushReplacementNamed('home');
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontFamily: 'ElMessiri',
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('signup');
                        },
                        child: const Text('Signup',
                            style: TextStyle(
                              fontFamily: 'ElMessiri',
                            ))),
                    Container(
                      height: 1,
                      width: 50,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:LLC/custom/button.dart';
import 'package:LLC/custom/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
GlobalKey<FormState> form = GlobalKey();

class _LoginState extends State<Login> {
  bool isLoading = false; // مؤشر تحميل

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://82.137.217.211:1010/api.php?action=trainee&username=$username&password=$password'), // URL الـ API الصحيح
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username.text, // القيمة من TextEditingController
          'password': password.text, // القيمة من TextEditingController
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          // نجاح تسجيل الدخول، انتقل إلى الصفحة الرئيسية
          Navigator.of(context).pushReplacementNamed('home');
        } else {
          // فشل تسجيل الدخول، عرض رسالة خطأ
          showErrorMessage(responseData['message'] ?? 'Login failed');
        }
      } else {
        showErrorMessage('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorMessage('Failed to connect to the server');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('hello');
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            Container(
              child: Image.asset("images/logo-dark.png"),
            ),
            const SizedBox(height: 100),
            CustomTextField(
              labelText: 'Username',
              icon: Icons.person,
              controller: username,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username must not be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Password',
              icon: Icons.lock,
              controller: password,
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password must not be empty";
                } else if (value.length < 8) {
                  return "Password must be at least\n 8 characters long";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator()) // مؤشر تحميل
                : CustomButton(
                    color: const Color(0xFF65598F),
                    text: 'Sign in',
                    onPressed: () {
                      if (form.currentState!.validate()) {
                        login(); // استدعاء دالة تسجيل الدخول
                      }
                    },
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontFamily: 'ElMessiri',
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('signup');
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 50,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
