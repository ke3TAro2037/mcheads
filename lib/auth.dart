/*
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();
  final String _apiBaseUrl = 'https://ke3taro2037.m31.coreserver.jp/mcheads';

  // 匿名ログインを実行
  Future<void> anonymousLogin() async {

    UserCredential userCredential;
    try {
      userCredential = await _auth.signInAnonymously();
      print('Anonymous login successful. UID: ${userCredential.user?.uid}');

      // ログイン後、APIトークンを取得
      await fetchAndStoreApiToken();
    } catch (e) {
      print('Anonymous login failed: $e');
    }
  }

  // APIトークンを取得して保存
  Future<void> fetchAndStoreApiToken() async {
    try {
      // FirebaseのUIDを取得
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final idToken = await user.getIdToken();

      // APIにリクエストを送信
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/firebase.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: json.encode({'id_token': idToken}),
      );

      if (response.statusCode == 200) {
        final apiToken = json.decode(response.body)['apikey'];

        // トークンをSecure Storageに保存
        await _storage.write(key: 'api_token', value: apiToken);
        print('API token saved successfully');
      } else {
        print('Failed to fetch API token: ${response.body}');
      }
    } catch (e) {
      print('Error fetching API token: $e');
    }
  }

  // Secure Storageからトークンを取得
  Future<String?> getApiToken() async {
    return await _storage.read(key: 'api_token');
  }

  // トークンの有効性を確認
  Future<bool> isApiTokenValid() async {
    try {
      final token = await getApiToken();
      if (token == null) return false;

      // APIにトークンの有効性を確認
      final response = await http.get(
        Uri.parse('$_apiBaseUrl/user.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error validating API token: $e');
      return false;
    }
  }

  // 再ログインを促進
  Future<void> ensureLoggedIn() async {
    final isValid = await isApiTokenValid();
    if (!isValid) {
      await anonymousLogin();
    }
  }
}
*/
