import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// アプリ起動時にログイン状態を確認し、ログイン中でなければ匿名ログインを実行
Future<void> checkAndSignIn(BuildContext context) async {
  try {
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      // 匿名ログインを実行
      UserCredential userCredential = await _auth.signInAnonymously();
      print('Anonymous account created. UID: ${userCredential.user?.uid}');
    } else {
      print('User already signed in. UID: ${currentUser.uid}');
    }

    // HomeScreenに遷移

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  } catch (e) {
    print('Error during sign-in check: $e');
  }
}

/// スプラッシュ画面で匿名ログインを確認
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 匿名ログイン処理
    checkAndSignIn(context);

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// メールアドレスとパスワードの設定画面
class EmailPasswordSetupScreen extends StatelessWidget {
  const EmailPasswordSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Email & Password')),
      body: const Center(
        child: Text('This is the Email & Password Setup Screen.'),
      ),
    );
  }
}

/// パスワードリセット画面
class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: const Center(
        child: Text('This is the Password Reset Screen.'),
      ),
    );
  }
}
