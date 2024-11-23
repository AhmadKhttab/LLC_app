import 'package:flutter/material.dart'; // استيراد مكتبة تصميم الواجهة في فلاتر لإنشاء الواجهات والتصميمات
import 'package:url_launcher/url_launcher.dart'; // استيراد مكتبة لفتح الروابط خارج التطبيق

// جعل الدالة قابلة لإعادة الاستخدام عن طريق تمرير الرابط كمعامل
Future<void> _launchUrl(String url) async {
  // تعريف دالة غير متزامنة لاستقبال رابط كمعامل
  final Uri _url = Uri.parse(url); // تحويل الرابط إلى كائن من نوع Uri
  if (!await launchUrl(_url)) {
    // محاولة فتح الرابط والتحقق من نجاح العملية
    throw Exception(
        'Could not launch $_url'); // رمي استثناء في حال فشل فتح الرابط
  }
}

class about extends StatelessWidget {
  // تعريف فئة الواجهة "about" وهي غير قابلة للتعديل
  @override
  Widget build(BuildContext context) {
    // دالة بناء الواجهة وتكوينها
    return Scaffold(
      appBar: AppBar(
        // شريط العنوان في أعلى الشاشة
        title: Text("About LLC", // عنوان الشريط
            style: TextStyle(
              // تنسيق النص
              fontFamily: 'ElMessiri',
            )),
        leading: IconButton(
          // زر للعودة للشاشة السابقة
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // أيقونة السهم للعودة بلون أبيض
          onPressed: () {
            // إجراء عند الضغط على الزر
            Navigator.pop(context); // العودة إلى الشاشة السابقة
          },
        ),
      ),
      body: ListView(
        // مكوّن لعرض محتويات الصفحة كقائمة قابلة للتمرير
        padding: EdgeInsets.all(16.0), // الهوامش المحيطة بعناصر القائمة
        children: [
          Row(
            // صف يحتوي على أيقونة ونص
            children: [
              Icon(Icons.info_outline,
                  color: Color(0XFFA18F5A)), // أيقونة "معلومات" بلون محدد
              SizedBox(width: 7), // مسافة عرضية بين الأيقونة والنص
              Text(
                "About", // نص "حول"
                style: TextStyle(
                    // تنسيق النص
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                    color: Color(0XFFA18F5A)),
              ),
            ],
          ),
          SizedBox(height: 16), // مسافة رأسية
          Container(
            // صندوق يحتوي على نص
            padding: EdgeInsets.all(10), // الهوامش الداخلية للصندوق
            decoration: BoxDecoration(
                // تزيين الصندوق بحواف ولون محدد
                borderRadius: BorderRadius.circular(10), // زوايا دائرية
                border: Border.all(
                  width: 0.5,
                  color: Color(0XFFA18F5A),
                )),
            child: Text(
              // نص مطوّل حول المركز التعليمي
              "In order to achieve the university’s vision and mission in following up on the needs of the community, and contributing to the provision of qualification and training opportunities for its various segments and in a way that contributes to its development, the university established the Training and Lifelong Learning Center within the scientific structure of the Syrian Virtual University specified in the internal regulation issued by Resolution No. /99/ of 2017.\nThe Continuous Learning and Training Program seeks to structure the vocational training system and leads it towards advanced fields by providing the trainee with skills that allow for breakthroughs in his work inside and outside Syria by Focusing on using the knowledge to solve practical issues, in order to enhance technical and behavioral skills of practical value.", // نص توضيحي عن المركز
              textAlign: TextAlign.justify, // محاذاة النص
              style: TextStyle(
                // تنسيق النص
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'ElMessiri',
              ),
            ),
          ),
          SizedBox(height: 24), // مسافة رأسية
          Divider(
            // خط فاصل بلون محدد
            color: Color(0XFFA18F5A),
          ),
          SizedBox(height: 16), // مسافة رأسية
          Row(
            // صف يحتوي على أيقونة ونص "تواصل معنا"
            children: [
              Icon(
                Icons.call,
                color: Color(0XFFA18F5A),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Contact Us", // نص "تواصل معنا"
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                    color: Color(0XFFA18F5A)),
              ),
            ],
          ),
          SizedBox(height: 16), // مسافة رأسية
          Row(
            // صف يحتوي على أيقونات وسائل التواصل
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // توزيع الأيقونات بالتساوي
            children: [
              Container(
                // أيقونة الموقع
                width: 50,
                height: 50,
                child: InkWell(
                  // خاصية تجعل الأيقونة قابلة للضغط
                  onTap: () {
                    // عند الضغط على الأيقونة
                    _launchUrl('https://llc.svuonline.org'); // فتح رابط الموقع
                  },
                  child: Image.asset('images/website.png'), // عرض صورة الأيقونة
                ),
              ),
              Container(
                // أيقونة البريد الإلكتروني
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    _launchUrl(
                        'mailto:llcinfo@svuonline.org'); // فتح البريد الإلكتروني
                  },
                  child: Image.asset('images/mail.png'),
                ),
              ),
              Container(
                // أيقونة الفيسبوك
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    _launchUrl(
                        'https://www.facebook.com/LLC.SVU?mibextid=ZbWKwL'); // فتح صفحة الفيسبوك
                  },
                  child: Image.asset('images/facebook.png'),
                ),
              ),
              Container(
                // أيقونة الإنستغرام
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    _launchUrl(
                        'https://www.instagram.com/lifelong_learning_center/profilecard/?igsh=MTNubTYxd3Vodjd5dA=='); // فتح صفحة الإنستغرام
                  },
                  child: Image.asset('images/instagram.png'),
                ),
              ),
              Container(
                // أيقونة اليوتيوب
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    _launchUrl(
                        'https://youtube.com/@lifelonglearningcenter?si=vKgCjFmLfDMKzb49'); // فتح قناة اليوتيوب
                  },
                  child: Image.asset('images/youtube.png'),
                ),
              ),
            ],
          ),
          SizedBox(height: 60), // مسافة رأسية
          Center(
            // عنصر مركزي يحتوي على الشعار ورقم النسخة
            child: Column(
              children: [
                Image.asset(
                  'images/logo-dark.png', // مسار الشعار
                  height: 60,
                ),
                SizedBox(height: 8), // مسافة بين الشعار والنص
                Text(
                  "Version Number 1.0", // نص رقم النسخة
                  style: TextStyle(color: Colors.grey, fontFamily: 'ElMessiri'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
