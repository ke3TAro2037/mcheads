import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'url.dart'; // URLページに遷移するためのインポート

class YoutubeWebView extends StatefulWidget {
  const YoutubeWebView({super.key});

  @override
  _YoutubeWebViewState createState() => _YoutubeWebViewState();
}

class _YoutubeWebViewState extends State<YoutubeWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // WebViewの初期化
    _controller = WebViewController();
    _controller
        .setJavaScriptMode(JavaScriptMode.unrestricted); // JavaScriptを有効にする
    _controller.loadRequest(Uri.parse(
        'https://m.youtube.com/')); // YouTube動画URLを読み込む
  }

  // 現在のURLを取得して別ページに渡す
  void _copyUrlAndNavigate() async {
    String url = await _controller.currentUrl() ?? '';
    if (url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => cutWebView(url: url),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('試合を選択してください'),
      ),
      body: WebViewWidget(controller: _controller), // WebViewにコントローラを渡す
      floatingActionButton: FloatingActionButton(
        onPressed: _copyUrlAndNavigate, // ボタンが押された時にURLをコピーして遷移
        child: const Icon(Icons.done),
      ),
    );
  }
}
