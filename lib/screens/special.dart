import 'dart:convert';
import 'package:LLC/api/Special.dart';
import 'package:LLC/screens/categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class special extends StatelessWidget {
  final int programId; // استلام الـ ID عبر الـ constructor
  final String programName; // استلام الاسم عبر الـ constructor

  special(
      {super.key,
      required this.programId,
      required this.programName}); // استلام المعرف والاسم

  // دالة fetchSubCategories المعدلة لاستقبال معرّف البرنامج
  Future<List<Special>> fetchSubCategories(int id) async {
    final response = await http.get(
      Uri.parse(
          'http://82.137.217.211:1010/api.php?action=specializations&program_id=$id'), // استخدام معرّف البرنامج هنا
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Special.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programName), // عرض اسم البرنامج في AppBar
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
      body: FutureBuilder<List<Special>>(
        future: fetchSubCategories(programId), // تمرير الـ ID هنا
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found'));
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

  Widget _buildCategoryCard(BuildContext context, String title,
      String description, int subCategoryId) {
    return InkWell(
      onTap: () {
        // التنقل إلى صفحة أخرى وتمرير البيانات (ID و Name)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => categories(
              subCategoryId: subCategoryId,
              title: title,
            ),
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
              child: Image.asset('images/spec.png'),
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
