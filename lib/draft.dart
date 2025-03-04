import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/main.dart';
import 'package:myapp/setting/account.dart';
import 'package:myapp/tabbar/my.dart';
import 'package:myapp/tabbar/trend.dart';


class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample()
      );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('保存された試合'),
          bottom: const PreferredSize(
    preferredSize: Size.fromHeight(48), // 高さを明示的に指定
    child: TabBar(
  labelPadding: EdgeInsets.all(0),
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: '保存済み', icon: Icon(Icons.folder)),
              Tab(text: 'トレンド', icon: Icon(Icons.explore)),
            ],
          ),
        ),
        )
      ,
        body: const TabBarView(
          children: <Widget>[
            MyScreen(),
            TrendScreen()
          ],
        ),
      ),
    );
  }
}