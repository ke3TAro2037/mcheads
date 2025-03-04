import 'package:flutter/material.dart';
import 'package:myapp/setting/login.dart';

import 'update.dart';
import 'login.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("設定"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("アカウント情報を更新"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
            ListTile(
              title: const Text("別のアカウントにログイン"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            ListTile(
              title: const Text("サブスクリプションを購入"),
              onTap: () {
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginToAnotherAccountScreen()),
                );
                */
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseSubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Subscription"),
      ),
      body: Center(
        child: const Text("Purchase Subscription Screen"),
      ),
    );
  }
}

class UpdateAccountInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Account Information"),
      ),
      body: Center(
        child: const Text("Update Account Information Screen"),
      ),
    );
  }
}

class LoginToAnotherAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Another Account"),
      ),
      body: Center(
        child: const Text("Login to Another Account Screen"),
      ),
    );
  }
}