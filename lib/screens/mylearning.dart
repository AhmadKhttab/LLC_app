import 'package:flutter/material.dart'; // استيراد مكتبة فلاتر الخاصة بالواجهة الرسومية.

class mylearning extends StatefulWidget {
  // تعريف فئة جديدة تسمى MyLearning، وهي فئة حالة (StatefulWidget).
  const mylearning({super.key}); // منشئ الفئة، مع إمكانية تمرير مفتاح.

  @override
  State<mylearning> createState() =>
      _mylearning(); // إنشاء حالة جديدة للفئة MyLearning.
}

class _mylearning extends State<mylearning>
    with SingleTickerProviderStateMixin {
  // تعريف حالة الفئة مع استخدام مزيج من SingleTickerProvider.
  late AnimationController
      _controller; // تعريف متغير للتحكم في الرسوم المتحركة.

  @override
  void initState() {
    // دالة يتم استدعاؤها عند إنشاء الحالة.
    super.initState(); // استدعاء دالة الحالة الأصلية.
    _controller = AnimationController(
        vsync: this); // إنشاء وحدة تحكم الرسوم المتحركة مع توفير عامل التزامن.
  }

  @override
  void dispose() {
    // دالة يتم استدعاؤها عند تدمير الحالة.
    _controller.dispose(); // تدمير وحدة التحكم للرسوم المتحركة لتحرير الموارد.
    super.dispose(); // استدعاء دالة التدمير الأصلية.
  }

  @override
  Widget build(BuildContext context) {
    // دالة لبناء واجهة المستخدم.
    return DefaultTabController(
      // استخدام وحدة تحكم علامات التبويب الافتراضية.
      length: 2, // تحديد عدد علامات التبويب.
      child: Scaffold(
        // إنشاء هيكل أساسي للواجهة.
        appBar: AppBar(
          // شريط التطبيق العلوي.
          title: const Text("My Learning"), // عنوان شريط التطبيق.
          bottom: const TabBar(tabs: [
            // إضافة علامات التبويب في أسفل شريط التطبيق.
            Tab(child: Text("Programs")), // علامة تبويب "البرامج".
            Tab(child: Text("Courses")), // علامة تبويب "الدورات".
          ]),
        ),
        backgroundColor: Colors.grey[400], // تعيين لون خلفية التطبيق.
        body: TabBarView(
          // عرض محتوى علامات التبويب.
          children: [
            _buildTabContent(
                context), // استدعاء دالة لإنشاء محتوى علامة التبويب الأولى.
            _buildTabContent(
                context), // استدعاء دالة لإنشاء محتوى علامة التبويب الثانية.
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    // دالة لإنشاء محتوى علامة التبويب.
    return Center(
      // محاذاة المحتوى في المركز.
      child: Container(
        // إنشاء حاوية جديدة.
        decoration: BoxDecoration(
          // تعيين تنسيق الحاوية.
          color: Colors.white, // تعيين لون خلفية الحاوية إلى الأبيض.
          borderRadius: BorderRadius.circular(20), // تعيين حواف دائرية للحاوية.
        ),
        height: 350, // تعيين ارتفاع الحاوية.
        width: 350, // تعيين عرض الحاوية.
        child: Column(
          // استخدام عمود لتنظيم المحتوى عموديًا.
          mainAxisAlignment:
              MainAxisAlignment.center, // محاذاة المحتوى في المنتصف عموديًا.
          children: [
            Center(
              // مركز آخر للمحتوى.
              child:
                  Image.asset('images/splash.png'), // عرض صورة من مجلد الصور.
            ),
            const SizedBox(height: 20), // إضافة مساحة بين الصورة والنص.
            Text(
              // إنشاء عنصر نص.
              "Don't have an account?", // النص المعروض للمستخدم.
              style: Theme.of(context)
                  .textTheme
                  .titleMedium, // استخدام نمط نص محدد من السمة.
            ),
            const SizedBox(height: 15), // إضافة مساحة بين النص والخطوط.
            Row(
              // استخدام صف لتنظيم خيارات تسجيل الدخول والتسجيل.
              mainAxisAlignment:
                  MainAxisAlignment.center, // محاذاة المحتوى في المنتصف أفقيًا.
              children: [
                _buildLoginOption(
                    context, "Login"), // استدعاء دالة لإنشاء خيار تسجيل الدخول.
                const SizedBox(
                    width:
                        10), // إضافة مساحة بين خيار تسجيل الدخول وعبارة "أو".
                const Text(
                  // نص ثابت يعبر عن الخيار.
                  'or',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'ElMessiri'), // تعيين حجم الخط ونوع الخط.
                ),
                const SizedBox(
                    width: 10), // إضافة مساحة بين "أو" وخيار التسجيل.
                _buildLoginOption(
                    context, "Signup"), // استدعاء دالة لإنشاء خيار التسجيل.
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginOption(BuildContext context, String title) {
    // دالة لإنشاء خيار تسجيل الدخول أو التسجيل.
    return Column(
      // استخدام عمود لتنظيم العناصر عموديًا.
      children: [
        InkWell(
          // عنصر تفاعلي يمكن الضغط عليه.
          onTap: () {
            // دالة حدث النقر.
            if (title == "Login") {
              // التحقق مما إذا كان الخيار هو تسجيل الدخول.
              Navigator.of(context).pushReplacementNamed(
                  'login'); // الانتقال إلى شاشة تسجيل الدخول.
            } else {
              // إذا كان الخيار هو تسجيل.
              Navigator.of(context)
                  .pushReplacementNamed('signup'); // الانتقال إلى شاشة التسجيل.
            }
          },
          child: Text(
            // إنشاء عنصر نص.
            title, // عرض عنوان الخيار (تسجيل الدخول أو التسجيل).
            style: Theme.of(context)
                .textTheme
                .titleSmall, // استخدام نمط نص محدد من السمة.
          ),
        ),
        Container(
          // حاوية لإنشاء خط فاصل.
          color: Colors.black, // تعيين لون الخط إلى الأسود.
          width: 50, // تعيين عرض الخط.
          height: 1, // تعيين ارتفاع الخط.
        ),
      ],
    );
  }
}
