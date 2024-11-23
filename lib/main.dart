// استيراد الحزم المطلوبة
import 'package:LLC/logs/hello.dart'; // استيراد صفحة الترحيب
import 'package:LLC/logs/login.dart'; // استيراد صفحة تسجيل الدخول
import 'package:LLC/logs/signup.dart'; // استيراد صفحة التسجيل
import 'package:LLC/logs/signup2.dart'; // استيراد صفحة التسجيل الثانية
import 'package:LLC/screens/Course.dart'; // استيراد صفحة الدورة
import 'package:LLC/screens/search.dart'; // استيراد صفحة البحث
import 'package:LLC/screens/about.dart'; // استيراد صفحة معلومات عنا
import 'package:LLC/screens/categories.dart'; // استيراد صفحة الفئات
import 'package:LLC/screens/home.dart'; // استيراد صفحة الصفحة الرئيسية
import 'package:LLC/screens/settings.dart'; // استيراد صفحة الإعدادات
import 'package:LLC/screens/special.dart'; // استيراد صفحة خاصة
import 'package:flutter/material.dart'; // استيراد مكتبة فلاتر المادية
// استيراد مكتبة HTTP للتعامل مع الطلبات الشبكية
import 'dart:convert'; // استيراد مكتبة تحويل JSON

// دالة رئيسية لتشغيل التطبيق
void main() {
  runApp(const LLCapp()); // تشغيل التطبيق باستخدام الـ widget الرئيسي LLCapp
}

// تعريف الـ widget الرئيسي للتطبيق
class LLCapp extends StatefulWidget {
  const LLCapp({super.key}); // مُنشئ الـ widget مع مفتاح فريد

  @override
  State<LLCapp> createState() =>
      _LLCappState(); // إنشاء الحالة الخاصة بالـ widget
}

// تعريف الحالة الخاصة بالـ widget
class _LLCappState extends State<LLCapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // إنشاء تطبيق مادي
        debugShowCheckedModeBanner:
            false, // عدم إظهار شريط التحقق في وضع التصحيح
        routes: {
          // تعريف طرق التنقل بين الصفحات
          'login': (context) => const Login(), // مسار صفحة تسجيل الدخول
          'signup': (context) => const signup(), // مسار صفحة التسجيل

          // مسار صفحة الفئات
          // 'subcategory': (context) => const subcategory(), // مسار صفحة الفئات الفرعية
          'settings': (context) => const settings(), // مسار صفحة الإعدادات
          'home': (context) => const home(), // مسار صفحة الصفحة الرئيسية
          'hello': (context) => const hello(), // مسار صفحة الترحيب
          // مسار صفحة خاصة
          // مسار صفحة الدورة
          'about': (context) => about(), // مسار صفحة معلومات عنا
          'search': (context) => SearchPage(), // مسار صفحة البحث
        },
        home: const hello(), // تعيين صفحة الترحيب كصفحة البداية
        theme: ThemeData(
            // تخصيص ثيم التطبيق
            textTheme: TextTheme(
                // تعريف أنماط النصوص
                bodyLarge: TextStyle(
                  // نمط النص الكبير
                  color: Colors.white, // تعيين لون النص إلى الأبيض
                  fontSize: 14, // تعيين حجم الخط إلى 14
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                ),
                titleSmall: TextStyle(
                  // نمط النص العنوان الصغير
                  color: Colors.black, // تعيين لون النص إلى الأسود
                  fontSize: 14, // تعيين حجم الخط إلى 14
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                ),
                titleMedium: TextStyle(
                  // نمط النص العنوان المتوسط
                  color: Colors.black, // تعيين لون النص إلى الأسود
                  fontSize: 14, // تعيين حجم الخط إلى 14
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                ),
                bodySmall: TextStyle(
                  // نمط النص الصغير
                  color: Color(0XFFA18F5A), // تعيين لون النص إلى لون مخصص
                  fontSize: 20, // تعيين حجم الخط إلى 20
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                )),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              // تخصيص مظهر شريط التنقل السفلي
              backgroundColor: Color(0xFF65598F), // تعيين لون خلفية شريط التنقل
              selectedItemColor: Color(0XFFA18F5A), // تعيين لون العنصر المحدد
              unselectedItemColor: Colors.grey, // تعيين لون العناصر غير المحددة
            ),
            appBarTheme: const AppBarTheme(
                // تخصيص مظهر شريط التطبيق
                backgroundColor:
                    Color(0xFF65598F), // تعيين لون خلفية شريط التطبيق
                titleTextStyle: TextStyle(
                  // تخصيص نمط نص العنوان
                  color: Colors.white, // تعيين لون النص إلى الأبيض
                  fontSize: 20, // تعيين حجم الخط إلى 20
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                )),
            tabBarTheme: TabBarTheme(
                // تخصيص مظهر شريط التبويبات
                labelStyle: const TextStyle(
                  // تخصيص نمط تسميات التبويبات
                  color: Colors.white, // تعيين لون النص إلى الأبيض
                  fontSize: 20, // تعيين حجم الخط إلى 20
                  fontFamily: 'ElMessiri', // تعيين نوع الخط
                ),
                indicatorColor: const Color(0XFFA18F5A), // تعيين لون المؤشر
                unselectedLabelColor:
                    Colors.grey[200]))); // تعيين لون النص للعناصر غير المحددة
  }
}
