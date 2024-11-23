import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لتصميم الواجهة

class fav extends StatefulWidget {
  const fav({super.key});

  @override
  State<fav> createState() => _favState();
}

class _favState extends State<fav> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // تحكم في التبديل بين التبويبات
        length: 2, // عدد التبويبات (2)
        child: Scaffold(
          appBar: AppBar(
            // شريط العنوان
            title: const Text("Favourite"),
            bottom: const TabBar(tabs: [
              // تبويبات "Programs" و "Courses"
              Tab(
                child: Text("Programs"),
              ),
              Tab(
                child: Text("Courses"),
              ),
            ]),
          ),
          backgroundColor: Colors.grey[400], // لون الخلفية
          body: Container(
            child: TabBarView(
              // عرض محتوى التبويبات
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20), // حواف دائرية
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                                'images/splash.png'), // صورة توضيحية
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Dont have an account ?", // رسالة بدون حساب
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            // خيارات "Login" و "Signup"
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    // تفاعل "Login"
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          'login'); // الانتقال لصفحة تسجيل الدخول
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
                                    width: 35,
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
                                      // تفاعل "Signup"
                                      onTap: () {
                                        Navigator.of(context).pushReplacementNamed(
                                            'signup'); // الانتقال لصفحة التسجيل
                                      },
                                      child: Text(
                                        "signup",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      )),
                                  Container(
                                    color: Colors.black,
                                    width: 40,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                                'images/splash.png'), // صورة توضيحية
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Dont have an account ?", // رسالة بدون حساب
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
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
                              const Text('or', style: TextStyle(fontSize: 18)),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  InkWell(
                                      child: Text(
                                    "signup",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )),
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
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
