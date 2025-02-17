import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/nav.dart';

const storage = FlutterSecureStorage();


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); // Firebaseの初期化

  //AdmobHelper.initialization();

  //final authService = AuthService();
  //await authService.ensureLoggedIn();

  //await storage.write(key: 'token', value: 'MBFSRV');
  storage.write(key: 'token', value: 'MBFSRV');

  //WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();


  

  // 最初に表示するWidget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      // アプリ名
      title: 'MCヘッズ',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: BottomNavScreen(),
    );
  }
}
