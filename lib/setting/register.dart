import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

              //greeting text

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

              //email text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
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
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メールアドレス',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0,),

              //password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'パスワード',
                      ),
                    ),
                  ),
                ),
              ),

              


              //login button
              const SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      ),)),
                ),
              ),
              //not a member? register now

              const SizedBox(height: 20.0,),
            ],
          ),
        ),
      ),
    );
  }
}