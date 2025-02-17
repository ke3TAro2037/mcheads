// Suggested code may be subject to a license. Learn more: ~LicenseLog:2564806120.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2323854486.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2376142655.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3561322406.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3039053273.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:27842.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1093985256.
import 'package:flutter/material.dart';
import './home.dart';
import 'youtube.dart';
import 'draft.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3), // 表示時間
      behavior: SnackBarBehavior.floating, // 浮かせて表示
      margin: const EdgeInsets.all(16), // 余白を設定
    ),
  );
}

const Color inActiveIconColor
 = Color(0xFFB6B6B6);

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentSelectedIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[

          HomePage(),
          TabBarApp(),
          YoutubeWebView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "ホーム",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: "保存した試合",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "試合を探す",
          ),
        ],
      ),
    );
  }
}
