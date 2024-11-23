import 'dart:convert';
import 'package:LLC/screens/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LLC/api/courses.dart';

class categories extends StatefulWidget {
  final int subCategoryId; // استلام ID الفئة عبر الـ constructor
  final String title; // استلام اسم الفئة عبر الـ constructor

  categories({required this.subCategoryId, required this.title});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<categories> {
  late Future<List<Courses>> futureCourses;

  Future<List<Courses>> fetchCourses(int subCategoryId) async {
    final response = await http.get(
      Uri.parse(
          'http://82.137.217.211:1010/api.php?action=courses_by_specialization&specialization_id=$subCategoryId'), // تمرير البرنامج ID هنا
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<Courses>((item) => Courses.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  void initState() {
    super.initState();
    futureCourses =
        fetchCourses(widget.subCategoryId); // تحميل الدورات بناءً على ID الفئة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // عرض اسم الفئة في الـ AppBar
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(); // العودة إلى الصفحة السابقة
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Courses>>(
        future: futureCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses found'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final subCategory = snapshot.data![index];
                return _buildCategoryCard(
                  context,
                  subCategory.Name_En ?? 'No Title', // عنوان الفئة
                  subCategory.Description ?? 'No Description', // الوصف
                  subCategory.id ?? 0, // تمرير الـ ID إلى الصفحة التالية
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String description, int CourseId) {
    return InkWell(
      onTap: () {
        // التنقل إلى صفحة أخرى وتمرير البيانات (ID و Name)
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Course(courseid: CourseId),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0XFFA18F5A), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 75,
              width: 75,
              child: Image.asset('images/course.png'),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
