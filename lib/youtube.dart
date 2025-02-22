import 'package:flutter/foundation.dart' show kIsWeb;
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
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      // WebViewの初期化 (Web版ではない場合)
      _controller = WebViewController();
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted); // JavaScriptを有効にする
      _controller.loadRequest(Uri.parse('https://m.youtube.com/')); // YouTube動画URLを読み込む
    }
  }

  // 現在のURLを取得して別ページに渡す
  void _copyUrlAndNavigate() async {
    String url = _urlController.text;
    if (url.isNotEmpty && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => cutWebView(url: url),
        ),
      );
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube URLを入力してください'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'YouTube URLを入力してください',
              ),
            ),
            const SizedBox(height: 20),
            if (!kIsWeb)
              Expanded(
                child: WebViewWidget(controller: _controller), // WebViewにコントローラを渡す
              ),
            ElevatedButton(
              onPressed: _copyUrlAndNavigate,
              child: const Text('送信'),
            ),
          ],
        ),
      ),
    );
  }
}