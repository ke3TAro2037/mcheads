import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:myapp/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? initUsername;
  String? initEmail;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    initUsername = await FlutterSecureStorage().read(key: 'username');
    initEmail = await const FlutterSecureStorage().read(key: 'email');
    setState(() {
      _usernameController.text = initUsername ?? '';
      _emailController.text = initEmail ?? '';
    });
  }

  Future<void> _updateAccountInfo() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    Map<String, String> data = {};
    if (username.isNotEmpty) data['username'] = username;
    if (email.isNotEmpty) data['email'] = email;
    if (password.isNotEmpty) data['password'] = password;
    print(data);

    if (data.isNotEmpty) {
      try {
        var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $globalToken'
      };
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/user.php',
        options: Options(
          method: 'PUT',
          headers: headers, 
        ),
        data: data,
      );

      print(response);

        if (response.statusCode == 200) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('アカウント情報が更新されました')),
          );
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('アカウント情報の更新に失敗しました')),
          );
        }
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アカウント情報の更新に失敗しました')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('少なくとも1つの項目を入力してください')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9E5DE),
      appBar: AppBar(
        title: const Text("アカウント情報を更新"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0,),
              Text("アカウント情報を更新",
                style: GoogleFonts.secularOne(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F1500),
                ),
              ),
              const SizedBox(height: 5.0,),
              const Text('現在ログイン中のアカウント情報を更新します。',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              const SizedBox(height: 40.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ユーザー名',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メールアドレス',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'パスワード',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: _updateAccountInfo,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF2F1500),
                    ),
                    child: const Center(
                      child: Text('保存',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
            ],
          ),
        ),
      ),
    );
  }
}