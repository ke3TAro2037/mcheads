import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart'; // assets へのアクセスに使用

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late WebViewController _controller;

  Future<String> _loadHtmlFromAssets() async {
    return await rootBundle
        .loadString('lib/player.html'); // assets から HTML を読み込む
  }

  Future<String> get_all_playlist(int playlistId) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?mode=all&playlist_id=$playlistId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      String replaceHtml = response.data['data'];
      return replaceHtml;
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  Future<String> create_player_html(int playlistId) async {
    String fullHtml =
        await rootBundle.loadString('lib/player.html'); // assets から HTML を読み込む
    String allPlaylist = await get_all_playlist(playlistId);
    allPlaylist =
        '[{"youtube_video_id": "W4euZ_wd0LI", "video_name": "Test Video 1", "start": 250, "end": 390}, {"youtube_video_id": "fTXtUeA7O1I", "video_name": "Test Video 2", "start": 250, "end": 390}]';
    String newText =
        fullHtml.replaceAll("ReplaceYourPlaylistArrayHere", allPlaylist);
    print(allPlaylist);
    return newText;
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (String url) async {
          // ページがロードされた後に処理を記述する場合はここに
        },
      ),
    );
    _loadHtmlFromAssets().then((html) {
      _controller.loadHtmlString(html); // HTML を読み込んで WebView にロード
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCバトルを再生中'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
