import 'dart:convert';
import 'package:LLC/screens/course.dart'; // تأكد من أن هذه الصفحة موجودة لديك
import 'package:LLC/screens/special.dart';
import 'package:http/http.dart' as http;
import 'package:LLC/api/courses.dart';
import 'package:LLC/api/program.dart';
import 'package:flutter/material.dart';

// صفحة البحث
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Program>> futureProgram;
  late Future<List<Courses>> futureCourses;

  List<Program> filteredPrograms = [];
  List<Courses> filteredCourses = [];
  TextEditingController searchController = TextEditingController();
  late TabController tabController;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabChange);

    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });

    futureProgram = fetchPrograms();
    futureCourses = fetchCourses();
  }

  Future<List<Program>> fetchPrograms() async {
    final response = await http
        .get(Uri.parse('http://82.137.217.211:1010/api.php?action=programs'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<Program>((item) => Program.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load programs');
    }
  }

  Future<List<Courses>> fetchCourses() async {
    final response = await http
        .get(Uri.parse('http://82.137.217.211:1010/api.php?action=courses'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<Courses>((item) => Courses.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
    });

    if (query.isNotEmpty) {
      if (tabController.index == 0) {
        futureProgram.then((programs) {
          setState(() {
            filteredPrograms = programs
                .where((program) => (program.Name_Ar?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false))
                .toList();
          });
        });
      } else {
        futureCourses.then((courses) {
          setState(() {
            filteredCourses = courses
                .where((course) => (course.Name_En?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false))
                .toList();
          });
        });
      }
    } else {
      setState(() {
        filteredPrograms = [];
        filteredCourses = [];
      });
    }
  }

  void _handleTabChange() {
    setState(() {
      filteredPrograms = [];
      filteredCourses = [];
    });
    filterSearchResults(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        searchController.clear();
                        filterSearchResults('');
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0XFFA18F5A), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0XFFA18F5A), width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(child: Text("Programs")),
              Tab(child: Text("Courses")),
            ],
          ),
        ),
        body: isSearching
            ? TabBarView(
                controller: tabController,
                children: [
                  // شاشة البرامج
                  FutureBuilder<List<Program>>(
                    future: futureProgram,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Programs found'));
                      } else {
                        List<Program> programs = snapshot.data!;
                        return ListView.builder(
                          itemCount: filteredPrograms.isNotEmpty
                              ? filteredPrograms.length
                              : programs.length,
                          itemBuilder: (context, index) {
                            Program program = filteredPrograms.isNotEmpty
                                ? filteredPrograms[index]
                                : programs[index];
                            return Container(
                              alignment: Alignment.center,
                              height: 75,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0XFFA18F5A), width: 1),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(program.Name_Ar ?? ''),
                                onTap: () {
                                  // عند الضغط على البرنامج، التنقل لصفحة التفاصيل
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => special(
                                        programId: program.id!,
                                        programName: program.Name_Ar ??
                                            "", // نفس الفكرة هنا
                                        // تمرير courseId من البرنامج
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  // شاشة الدورات
                  FutureBuilder<List<Courses>>(
                    future: futureCourses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Courses found'));
                      } else {
                        List<Courses> courses = snapshot.data!;
                        return ListView.builder(
                          itemCount: filteredCourses.isNotEmpty
                              ? filteredCourses.length
                              : courses.length,
                          itemBuilder: (context, index) {
                            Courses course = filteredCourses.isNotEmpty
                                ? filteredCourses[index]
                                : courses[index];
                            return Container(
                              alignment: Alignment.center,
                              height: 75,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0XFFA18F5A), width: 1),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(course.Name_En ?? 'No Name'),
                                onTap: () {
                                  // عند الضغط على الدورة، التنقل لصفحة التفاصيل مع تمرير courseId
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Course(
                                        courseid: course.id!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              )
            : Center(child: Text("Please start typing to search")),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    tabController.dispose();
    super.dispose();
  }
}
