import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMinimized = false;
  double _bottomSheetHeight = 1.0;  // 全画面の高さ管理

  void _toggleMinimize() {
    setState(() {
      _isMinimized = !_isMinimized;
      _bottomSheetHeight = _isMinimized ? 0.1 : 1.0; // 最小化/最大化の状態で高さを変更
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Popup Demo")),
      body: Stack(
        children: [
          // 本来のコンテンツ
          Center(child: Text("Main Content")),

          // 最小化されたポップアップ（BottomNavBarの上に表示）
          if (_isMinimized)
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: _toggleMinimize, // タップで最大化
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  color: Colors.blue,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Minimized View'),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isMinimized = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _isMinimized
          ? null // BottomNavBarが隠れる
          : BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: MediaQuery.of(context).size.height * _bottomSheetHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_down),
                            onPressed: _toggleMinimize, // 最小化処理
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(child: Text("Full Screen Content")),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
