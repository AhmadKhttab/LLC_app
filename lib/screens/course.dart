import 'package:LLC/api/Trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LLC/api/courses.dart';

class Course extends StatelessWidget {
  final int courseid; // استلام CourseId لطلب بيانات الدورة من API

  Course({super.key, required this.courseid});

  // دالة لجلب بيانات الدورة من API بناءً على CourseId
  Future<Courses> fetchCourseDetails() async {
    final response = await http.get(Uri.parse(
        'http://82.137.217.211:1010/api.php?action=course&id=$courseid'));

    if (response.statusCode == 200) {
      // فك شفرة الاستجابة إلى كائن JSON مباشر
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Courses.fromJson(jsonResponse); // تحويل الكائن إلى Courses
    } else {
      throw Exception('Failed to load course details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<Courses>(
        future: fetchCourseDetails(), // جلب بيانات الدورة بناءً على CourseId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          // إذا تم استلام البيانات بنجاح
          final course = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF65598F),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        course.Name_En ?? "", // عرض عنوان الدورة
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        course.Description ??
                            "No Description Available", // عرض الوصف
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Course Description:'),
                      _buildBulletPoints(
                          [course.Description ?? "No Description Available"]),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Fees of course:'),
                      _buildBulletPoints(['500.000 SYP', '100 USD', '100 EUR']),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Trainer name: '),
                      _buildCreatorInfo("Ahmed Al-Sharqawi"),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF65598F),
            ),
            onPressed: () {
              showPopupCard(
                context: context,
                builder: (context) {
                  return PopupCard(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      height: 320,
                      width: 300,
                      child: Column(
                        children: [
                          Center(child: Image.asset('images/splash.png')),
                          const SizedBox(height: 20),
                          Text("Don't have an account?",
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('login');
                                    },
                                    child: Text("Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                  Container(
                                      color: Colors.black,
                                      width: 50,
                                      height: 1),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Text('or', style: TextStyle(fontSize: 18)),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('signup');
                                    },
                                    child: Text("Signup",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                  Container(
                                      color: Colors.black,
                                      width: 50,
                                      height: 1),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text(
              'Registration',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF65598F),
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: points.map((point) {
        return Row(
          children: [
            Icon(Icons.circle, size: 6, color: Colors.black),
            SizedBox(width: 8),
            Text(
              point,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCreatorInfo(String trainerName) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('images/ph1.jpg'),
          radius: 30,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trainerName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
