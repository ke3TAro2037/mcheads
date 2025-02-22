import 'intro.dart';
import 'package:myapp/nav.dart';
import 'package:myapp/test.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
String? globalToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //正式リリース時は、こちらを無効化する
  storage.write(key: 'token', value: 'MBFSRV');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _getToken() async {    
    globalToken = await storage.read(key: 'token');
    return await storage.read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MCヘッズ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<String?>(
        future: _getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            //return BottomNavScreen();
            return BottomNavScreen();
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}