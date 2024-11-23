import 'package:LLC/screens/favourite.dart';
import 'package:LLC/screens/homebit.dart';
import 'package:LLC/screens/mylearning.dart';
import 'package:LLC/screens/settings.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selectedIndex = 0; // لتتبع الصفحة الحالية
  final List<Widget> _pages = []; // قائمة الشاشات

  // دالة لتحديث المؤشر عند النقر على العناصر
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages.addAll([
      // إضافة الشاشات إلى القائمة عند بدء التشغيل
      homebot(),
      const mylearning(),
      const fav(),
      const settings(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // شريط التنقل السفلي
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: 'My Learning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex, // العنصر النشط
          iconSize: 35,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped, // استدعاء الدالة لتغيير المؤشر عند النقر
        ),
        body: _pages[_selectedIndex]); // عرض الصفحة المختارة
  }
}
