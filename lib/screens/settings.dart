import 'package:flutter/material.dart'; // استيراد مكتبة فلاتر الأساسية
import 'package:flutter_popup_card/flutter_popup_card.dart'; // استيراد مكتبة البطاقة المنبثقة
import 'package:share_plus/share_plus.dart'; // استيراد مكتبة المشاركة

class settings extends StatelessWidget {
  // تعريف صف الـ Settings
  const settings({Key? key})
      : super(key: key); // مُنشئ الـ widget مع مفتاح فريد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // هيكل الصفحة الرئيسية
      appBar: AppBar(
        // شريط التطبيق
        title: const Text("More"), // عنوان شريط التطبيق
      ),
      body: ListView(
        // قائمة قابلة للتمرير
        padding: const EdgeInsets.symmetric(vertical: 10), // هوامش قائمة
        children: [
          ListTile(
            // عنصر قائمة
            leading: const Icon(
              Icons.person,
              color: Color(0XFFA18F5A), // لون الأيقونة
            ),
            title: Text(
              "My Profile", // عنوان العنصر
              style: Theme.of(context).textTheme.bodySmall, // نمط النص
            ),
            onTap: () {
              // إجراء عند الضغط على العنصر
              showPopupCard(
                context: context,
                builder: (context) {
                  // بناء البطاقة المنبثقة
                  return PopupCard(
                    elevation: 8, // ظل البطاقة
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // شكل البطاقة
                    ),
                    child: Container(
                      height: 320, // ارتفاع البطاقة
                      width: 300, // عرض البطاقة
                      child: Column(
                        // عمود المحتوى داخل البطاقة
                        children: [
                          Center(
                            child: Image.asset('images/splash.png'), // صورة
                          ),
                          const SizedBox(height: 20), // مساحة فارغة
                          Text(
                            "Don't have an account?", // نص
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 15), // مساحة فارغة
                          Row(
                            // صف لتنظيم الأزرار
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                // عمود لزر تسجيل الدخول
                                children: [
                                  InkWell(
                                    // عنصر قابل للنقر
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          'login'); // الانتقال إلى صفحة تسجيل الدخول
                                    },
                                    child: Text(
                                      "Login", // نص الزر
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black,
                                    width: 35, // عرض الخط
                                    height: 1, // ارتفاع الخط
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10), // مساحة فارغة
                              const Text('or', // نص "أو"
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'ElMessiri',
                                  )),
                              const SizedBox(width: 10), // مساحة فارغة
                              Column(
                                // عمود لزر التسجيل
                                children: [
                                  InkWell(
                                    // عنصر قابل للنقر
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          'signup'); // الانتقال إلى صفحة التسجيل
                                    },
                                    child: Text(
                                      "Signup", // نص الزر
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black,
                                    width: 40, // عرض الخط
                                    height: 1, // ارتفاع الخط
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
                alignment: Alignment.center, // محاذاة البطاقة
                useSafeArea: true, // استخدام المنطقة الآمنة
                dimBackground: true, // تعتيم الخلفية
              );
            },
          ),
          const Divider(), // فاصل
          _buildSectionTitle(
              "Account Settings", context), // عنوان إعدادات الحساب
          _buildSettingsOption("Change password", onTap: () {
            // خيار تغيير كلمة المرور
            showPopupCard(
              context: context,
              builder: (context) {
                // بناء البطاقة المنبثقة
                return PopupCard(
                  elevation: 8, // ظل البطاقة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // شكل البطاقة
                  ),
                  child: Container(
                    height: 320, // ارتفاع البطاقة
                    width: 300, // عرض البطاقة
                    child: Column(
                      // عمود المحتوى داخل البطاقة
                      children: [
                        Center(
                          child: Image.asset('images/splash.png'), // صورة
                        ),
                        const SizedBox(height: 20), // مساحة فارغة
                        Text(
                          "Don't have an account?", // نص
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 15), // مساحة فارغة
                        Row(
                          // صف لتنظيم الأزرار
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              // عمود لزر تسجيل الدخول
                              children: [
                                InkWell(
                                  // عنصر قابل للنقر
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        'login'); // الانتقال إلى صفحة تسجيل الدخول
                                  },
                                  child: Text(
                                    "Login", // نص الزر
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 35, // عرض الخط
                                  height: 1, // ارتفاع الخط
                                ),
                              ],
                            ),
                            const SizedBox(width: 10), // مساحة فارغة
                            const Text('or', // نص "أو"
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'ElMessiri',
                                )),
                            const SizedBox(width: 10), // مساحة فارغة
                            Column(
                              // عمود لزر التسجيل
                              children: [
                                InkWell(
                                    // عنصر قابل للنقر
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          'signup'); // الانتقال إلى صفحة التسجيل
                                    },
                                    child: Text(
                                      "Signup", // نص الزر
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )),
                                Container(
                                  color: Colors.black,
                                  width: 40, // عرض الخط
                                  height: 1, // ارتفاع الخط
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
              alignment: Alignment.center, // محاذاة البطاقة
              useSafeArea: true, // استخدام المنطقة الآمنة
              dimBackground: true, // تعتيم الخلفية
            );
          }),
          _buildSettingsOption("Dashboard", onTap: () {
            // خيار لوحة التحكم
            showPopupCard(
              context: context,
              builder: (context) {
                // بناء البطاقة المنبثقة
                return PopupCard(
                  elevation: 8, // ظل البطاقة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // شكل البطاقة
                  ),
                  child: Container(
                    height: 320, // ارتفاع البطاقة
                    width: 300, // عرض البطاقة
                    child: Column(
                      // عمود المحتوى داخل البطاقة
                      children: [
                        Center(
                          child: Image.asset('images/splash.png'), // صورة
                        ),
                        const SizedBox(height: 20), // مساحة فارغة
                        Text(
                          "Don't have an account?", // نص
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 15), // مساحة فارغة
                        Row(
                          // صف لتنظيم الأزرار
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              // عمود لزر تسجيل الدخول
                              children: [
                                InkWell(
                                  // عنصر قابل للنقر
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        'login'); // الانتقال إلى صفحة تسجيل الدخول
                                  },
                                  child: Text(
                                    "Login", // نص الزر
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  width: 35, // عرض الخط
                                  height: 1, // ارتفاع الخط
                                ),
                              ],
                            ),
                            const SizedBox(width: 10), // مساحة فارغة
                            const Text('or', // نص "أو"
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'ElMessiri',
                                )),
                            const SizedBox(width: 10), // مساحة فارغة
                            Column(
                              // عمود لزر التسجيل
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          'signup'); // الانتقال إلى صفحة التسجيل
                                    },
                                    child: Text(
                                      "Signup", // نص الزر
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )),
                                Container(
                                  color: Colors.black,
                                  width: 40, // عرض الخط
                                  height: 1, // ارتفاع الخط
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
              alignment: Alignment.center, // محاذاة البطاقة
              useSafeArea: true, // استخدام المنطقة الآمنة
              dimBackground: true, // تعتيم الخلفية
            );
          }),
          _buildSettingsOption("Language", // خيار اللغة
              trailing: const Text("English"),
              onTap: () {}), // نص إضافي
          const Divider(), // فاصل
          _buildSectionTitle("Support", context), // عنوان الدعم
          _buildSettingsOption("About LLC", onTap: () {
            // خيار "حول الشركة"
            Navigator.of(context).pushNamed('about'); // الانتقال إلى صفحة "حول"
          }),
          _buildSettingsOption("Share LLC app", onTap: () {
            // خيار "مشاركة التطبيق"
            Share.share(
                'Check out this amazing app: [https://drive.google.com/drive/folders/15SKFH4_2faqekJSS72vK8ACrwb0rMnxa?usp=sharing ]'); // مشاركة الرابط
          }),
          const Divider(), // فاصل
          ListTile(
            // عنصر قائمة لتسجيل الدخول
            leading: const Icon(
              Icons.login,
              color: Color(0XFFA18F5A), // لون الأيقونة
            ),
            title: Text(
              "Sign In", // نص العنصر
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              // إجراء عند الضغط على العنصر
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (routes) => false); // الانتقال إلى صفحة تسجيل الدخول
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // هوامش العنوان
      child: Row(
        // صف لعنوان القسم
        children: [
          Icon(
            title == "Account Settings"
                ? Icons.settings
                : Icons.help_outline, // أيقونة العنوان
            color: Color(0XFFA18F5A),
          ),
          const SizedBox(width: 10), // مساحة فارغة
          Text(
            title, // نص العنوان
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(String title,
      {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title), // نص العنصر
      onTap: onTap, // الإجراء عند الضغط
    );
  }
}
