import 'dart:async';
import 'package:LLC/api/Trainer.dart';
import 'package:LLC/api/Trainer.dart';
import 'package:LLC/api/ads.dart';

import 'package:LLC/api/courses.dart';
import 'package:LLC/api/event.dart';
import 'package:LLC/api/program.dart';
import 'package:LLC/api/Trainer.dart';
import 'package:LLC/screens/course.dart';
import 'package:LLC/screens/search.dart';
import 'package:LLC/screens/special.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup_card/flutter_popup_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/Trainer.dart';

class homebot extends StatefulWidget {
  const homebot({super.key});

  @override
  State<homebot> createState() => _homebotState();
}

late Future<List<Program>> futureProgram;
Future<List<Program>> fetchPrograms() async {
  final response = await http
      .get(Uri.parse('http://82.137.217.211:1010/api.php?action=programs'));

  if (response.statusCode == 200) {
    // Decode the JSON response and convert it to a list of Programs
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map<Program>((item) => Program.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load programs');
  }
}

late Future<List<ads>> futureads;
Future<List<ads>> fetchads() async {
  final response = await http.get(
      Uri.parse('http://82.137.217.211:1010/api.php?action=advertisements'));

  if (response.statusCode == 200) {
    // Decode the JSON response and convert it to a list of Programs
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map<ads>((item) => ads.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load programs');
  }
}

late Future<List<Courses>> futureCourses;

Future<List<Courses>> fetchCourses() async {
  final response = await http
      .get(Uri.parse('http://82.137.217.211:1010/api.php?action=courses'));

  if (response.statusCode == 200) {
    // Decode the JSON response and convert it to a list of Programs
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map<Courses>((item) => Courses.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load programs');
  }
}

late Future<List<Event>> futureEvent;

Future<List<Event>> fetchEvent() async {
  final response = await http.get(
      Uri.parse('http://82.137.217.211:1010/api.php?action=LLCevdddddents'));

  if (response.statusCode == 200) {
    // Decode the JSON response and convert it to a list of Programs
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map<Event>((item) => Event.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load programs');
  }
}

Future<String> fetchEventDescription(int eventId) async {
  final response = await http.get(Uri.parse(
      'http://82.137.217.211:1010/api.php?action=getCourseDescription&id=$eventId'));

  if (response.statusCode == 200) {
    // تأكد من أن الـ API يعيد الوصف في الحقل المناسب
    var jsonResponse = json.decode(response.body);
    return jsonResponse['description'] ?? 'لا يوجد وصف للكورس';
  } else {
    throw Exception('فشل في تحميل الوصف');
  }
}

late Future<List<Trainerss>> futureTrainers;

Future<List<Trainerss>> fetchTrainers() async {
  final response = await http
      .get(Uri.parse('http://82.137.217.211:1010/api.php?action=trainers'));

  if (response.statusCode == 200) {
    // Decode the JSON response and convert it to a list of Events
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map<Trainerss>((item) => Trainerss.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load events');
  }
}

class _homebotState extends State<homebot> {
  final PageController _adsPageController = PageController();
  final PageController _eventPageController = PageController();
  int _currentAdsPage = 0;
  int _currentEventPage = 0;
  Timer? _timer;

  final List<String> adImages = [
    'images/ph1.jpg',
    'images/ph2.jpg',
    'images/ph3.jpg',
    'images/ph1.jpg',
    'images/ph2.jpg',
  ];

  void startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentAdsPage < adImages.length - 1) {
        _currentAdsPage++;
      } else {
        _currentAdsPage = 0;
      }
      _adsPageController.animateToPage(
        _currentAdsPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
  }

  late Future<List<Program>> futureProgram;
  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  void initState() {
    super.initState();
    futureProgram = fetchPrograms();
    futureCourses = fetchCourses();
    futureEvent = fetchEvent();
    futureTrainers = fetchTrainers();
    futureads = fetchads();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffold,
        body: ListView(
          children: [
            SizedBox(
              height: 170,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'images/search.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 30,
                    right: 30,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Color(0XFFA18F5A),
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      height: 50,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('search');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search",
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.search, color: Colors.black)
                            ],
                          )),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: InkWell(
                      onTap: () {
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
                                    Center(
                                      child: Image.asset('images/splash.png'),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Don't have an account?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        'login');
                                              },
                                              child: Text(
                                                "Login",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.black,
                                              width: 50,
                                              height: 1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('or',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'ElMessiri',
                                            )),
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        'signup');
                                              },
                                              child: Text(
                                                "Signup",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.black,
                                              width: 50,
                                              height: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          alignment: Alignment.center,
                          useSafeArea: true,
                          dimBackground: true,
                        );
                      },
                      child: const Icon(
                        Icons.notifications_sharp,
                        color: Color(0XFFA18F5A),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: const Text(
                '   Programs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder<List<Program>>(
                future: futureProgram,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No programs found');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final program = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            // عند الضغط على البرنامج، يتم الانتقال إلى صفحة الكورسات مع تمرير ID البرنامج
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => special(
                                  programId: program.id!,
                                  programName:
                                      program.Name_Ar ?? 'Fallback Name',
                                ), // استخدام الـ '!' لتحويله إلى int
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0XFFA18F5A)),
                              color: const Color(0xFF65598F),
                            ),
                            height: 75,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  program.Name_Ar ?? 'Fallback Text',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              child: const Text(
                '   Advertisements',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            SizedBox(
                height: 250,
                child: FutureBuilder<List<ads>>(
                    future:
                        futureads, // تأكد من أن الدالة futureCourses تعمل بشكل صحيح
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No Advertisements found');
                      } else {
                        return PageView.builder(
                          controller: _adsPageController,
                          itemCount: adImages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentAdsPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final advers = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                showPopupCard(
                                  context: context,
                                  builder: (context) {
                                    return PopupCard(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        height: 320,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Text(
                                              advers.Title ?? "",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF65598F),
                                              ),
                                            ),
                                            Text(advers.Description ?? "")
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  alignment: Alignment.center,
                                  useSafeArea: true,
                                  dimBackground: true,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(adImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    })),
            Center(
              child: SmoothPageIndicator(
                controller: _adsPageController,
                count: adImages.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Color(0XFFA18F5A),
                  dotColor: Colors.grey,
                ),
              ),
            ),
            Container(
              child: const Text(
                '   Courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: FutureBuilder<List<Courses>>(
                future:
                    futureCourses, // تأكد من أن الدالة futureCourses تعمل بشكل صحيح
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No courses found');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final courses = snapshot.data![
                            index]; // Get the specific course at the index
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Course(
                                    courseid: courses
                                        .id!), // تعديل هنا إلى CourseDetailsPage
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0XFFA18F5A)),
                                color: const Color(0xFF65598F)),
                            height: 75,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  courses.Name_En ?? 'Fallback Text',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              child: const Text(
                '   Event',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'ElMessiri',
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder<List<Event>>(
                future: futureEvent,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No events found');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final event =
                            snapshot.data![index]; // الحصول على الكورس المحدد
                        return InkWell(
                            onTap: () {
                              // التأكد من أن الـ id ليس null
                              if (event.id != null) {
                                // عند الضغط على الكورس، نعرض الوصف في نافذة منبثقة
                                showPopupCard(
                                  context: context,
                                  builder: (context) {
                                    return FutureBuilder<String>(
                                      future: fetchEventDescription(
                                          event.id!), // تحميل الوصف من الـ API
                                      builder: (context, descriptionSnapshot) {
                                        if (descriptionSnapshot
                                                .connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (descriptionSnapshot
                                            .hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${descriptionSnapshot.error}'));
                                        } else if (!descriptionSnapshot
                                                .hasData ||
                                            descriptionSnapshot.data!.isEmpty) {
                                          return Center(
                                              child: Text('لا يوجد وصف للحدث'));
                                        } else {
                                          return PopupCard(
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end, // تعديل المحاذاة إلى أقصى اليمين
                                                children: [
                                                  SizedBox(height: 10),
                                                  // التأكد من أن الوصف ليس null
                                                  Text(
                                                    event.Description ??
                                                        'لا يوجد وصف للحدث',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                  alignment: Alignment.center,
                                  useSafeArea: true,
                                  dimBackground: true,
                                );
                              } else {
                                // في حال كان الـ id null، نعرض رسالة خطأ
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('معرّف الكورس غير موجود!')),
                                );
                              }
                            },
                            child: InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Color(0XFFA18F5A)),
                                    color: const Color(0xFF65598F)),
                                height: 75,
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      event.Name_En ?? 'لا يوجد وصف للكورس',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Trainer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                    onPressed: () {
                      scaffold.currentState!.showBottomSheet((context) =>
                          SizedBox(
                            height: 115,
                            width: double.infinity,
                            child: FutureBuilder<List<Trainerss>>(
                              future: futureTrainers,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Text('No events found');
                                } else {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis
                                        .horizontal, // Enables horizontal scrolling
                                    child: Row(
                                      children: snapshot.data!.map((trainer) {
                                        return InkWell(
                                          // Prevent tapping on a null id (if needed)
                                          child: Container(
                                            width: 400,
                                            height: 200,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  width: 75,
                                                  height: 75,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/ph1.jpg'), // Adjust path to the image if needed
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      height: 30,
                                                      width: 230,
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 30,
                                                            ),
                                                            Text(
                                                              trainer.First_Name_En ??
                                                                  'No Arabic Name',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'ElMessiri',
                                                              ),
                                                            ),
                                                            Text(
                                                              trainer.Last_Name_En ??
                                                                  'No Arabic Name',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'ElMessiri',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        Text(
                                                          trainer.course_count
                                                                  ?.toString() ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ), // If course_count is null, fallback to an empty string
                                                        ),
                                                        Text(
                                                          " Material",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'ElMessiri',
                                                          ), // If course_count is null, fallback to an empty string
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 75,
                                                  width: 3,
                                                  color: Color(0xFF65598F),
                                                ),
                                                const SizedBox(width: 25),
                                                Center(
                                                  child: Icon(
                                                    Icons.arrow_circle_right,
                                                    size: 35,
                                                    color: Color(0XFFA18F5A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ));
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
