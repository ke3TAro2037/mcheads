import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/nav.dart';

class OnboardingScreen extends StatelessWidget {
  final storage = FlutterSecureStorage();

  Future<void> _onDone(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://api.made-by-free.com/mcheads/user.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      await storage.write(key: 'username', value: data['username']);
      await storage.write(key: 'id', value: data['id']);
      await storage.write(key: 'token', value: data['token']);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomNavScreen()),
      );
    } else {
      // Handle error
      print('Failed to register user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "ようこそ",
          body: "これはシンプルなオンボーディング画面です。",
          image: Center(child: Icon(Icons.accessibility, size: 100)),
        ),
        PageViewModel(
          title: "簡単操作",
          body: "アプリの特徴を簡単に紹介します。",
          image: Center(child: Icon(Icons.touch_app, size: 100)),
        ),
        PageViewModel(
          title: "始めましょう",
          body: "オンボーディングはこれで完了です！",
          image: Center(child: Icon(Icons.check_circle, size: 100)),
        ),
      ],
      onDone: () => _onDone(context),
      showSkipButton: true,
      skip: const Text("スキップ"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("完了", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
