import 'dart:math';
import 'package:myapp/video.dart';

import 'draft.dart';
import './home.dart';
import 'youtube.dart';
import 'package:myapp/player.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );
}


void _showFullScreenPlayer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          child: Center(
            child: Text(
              "Full Screen Player",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

const Color inActiveIconColor = Color(0xFFB6B6B6);

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentSelectedIndex = 0;
  final PageController _pageController = PageController();
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

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
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-4369743565857604/9072905814',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
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
          HomeScreen(),
          TabBarApp(),
          YoutubeWebView(),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _showFullScreenPlayer(context),
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 180, 234).withAlpha(150),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.black54),
                      SizedBox(width: 10),
                      Text(
                        "Now Playing",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //Icon(Icons.play_arrow, color: Colors.black54),
                ],
              ),
            ),
          ),
          BottomNavigationBar(
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
        ],
      ),
    );
  }
}