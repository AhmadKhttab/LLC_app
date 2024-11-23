import 'package:LLC/logs/login.dart';
import 'package:LLC/logs/signup.dart';
import 'package:flutter/material.dart';

class hello extends StatefulWidget {
  const hello({super.key});

  @override
  State<hello> createState() => _loginState();
}

class _loginState extends State<hello> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(),
                child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      'images/welcome.png',
                      fit: BoxFit.cover,
                    )),
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Container(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome To",
                          style: TextStyle(
                              color: Color(0xFF65598F),
                              fontSize: 30,
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "LLC",
                          style: TextStyle(
                              color: Color(0XFFA18F5A),
                              fontSize: 30,
                              fontFamily: 'ElMessiri',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: const Text("Lifelong Learning Center",
                        style: TextStyle(
                            color: Color(0XFFA18F5A),
                            fontSize: 25,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 400,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF65598F),
                          borderRadius: BorderRadius.circular(20)),
                      child: MaterialButton(
                          minWidth: 200,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login()));
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'ElMessiri',
                              fontSize: 20,
                            ),
                          ))),
                  const SizedBox(
                    height: 70,
                  ),
                  const Text("Dont Have an Account ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ElMessiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const signup()));
                            },
                            child: const Text("Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ElMessiri',
                                  fontSize: 20,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        children: [
                          Text(
                            '|',
                            style: TextStyle(
                              color: Color(0XFFA18F5A),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('home');
                            },
                            child: const Text("Register as a Guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ElMessiri',
                                  fontSize: 20,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
