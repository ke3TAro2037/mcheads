import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String? extractYouTubeVideoId(String url) {
  // 正規表現パターンを定義
  final RegExp regExp = RegExp(
    r'(?:https?://)?(?:www\.|m\.)?(?:youtube\.com/watch\?v=|youtu\.be/)([\w-]{11})',
    caseSensitive: false,
  );

  // マッチを取得
  final match = regExp.firstMatch(url);

  // マッチがあればビデオIDを返す
  if (match != null) {
    return match.group(1); // ビデオIDはキャプチャグループ1
  }

  // マッチしない場合はnullを返す
  return null;
}

class cutWebView extends StatefulWidget {
  const cutWebView({super.key, required this.url});

  final String url;

  @override
  _cutWebViewState createState() => _cutWebViewState();
}

class _cutWebViewState extends State<cutWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    String? videoId = extractYouTubeVideoId(widget.url);
    // WebViewを初期化
    _controller = WebViewController();
    _controller.setJavaScriptMode(
        JavaScriptMode.unrestricted); // インスタンスを使ってJavaScriptを有効にする
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (String url) async {
          // ページのロードが完了したらリストをWebViewに送信
          await _controller
              .runJavaScript('window.receiveData($url)'); // WebViewにデータを渡す
        },
      ),
    );
    _controller.loadRequest(Uri.parse(
        'https://made-by-free.com/youtube_app/editor2.html?video_id={$videoId}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('試合を編集'),
      ),
      body: WebViewWidget(controller: _controller), // WebViewにコントローラを渡す
    );
  }
}
