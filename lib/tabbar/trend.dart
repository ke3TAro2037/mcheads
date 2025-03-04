import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:myapp/home.dart';
import 'package:myapp/main.dart';
import 'package:myapp/video.dart';

class TrendScreen extends StatefulWidget {
  const TrendScreen({super.key});

  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {
  late List<Map<String, String>> videoList = [];
  late List<int> videoIdInts = []; //動画idを管理するList
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPlaylistData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchPlaylistData({int page = 1}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $globalToken'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?mode=trend&page=$page',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      print(response.data);

      final Map<String, dynamic> jsonData = response.data;
      if (jsonData['status'] == 200 && jsonData['data'] != null) {
        final String videosString = jsonData['data'];
        final List<String> videoIds = videosString
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',')
            .map((e) => e.trim())
            .toList();
        //APIが数字型で返してくる場合に変換する
        videoIdInts = videoIds.map((id) => int.tryParse(id) ?? 0).toList();

        List<Map<String, String>> fetchedVideos = [];
        for (int videoId in videoIdInts) {
          // ここで動画の詳細を取得するAPIを叩く
          final videoDetails = await fetchVideoDetails(videoId);
          if (videoDetails != null) {
            fetchedVideos.add(videoDetails);
          }
        }

        setState(() {
          videoList.addAll(fetchedVideos);
          _currentPage++;
        });
      } else {
        print('API request failed: ${response.statusCode}');
        // エラー処理
      }
    } catch (e) {
      throw Exception('API request failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Map<String, String>?> fetchVideoDetails(int videoId) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $globalToken'
      };
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/video.php?video_id=$videoId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      print(response.data);
      final Map<String, dynamic> videoData = response.data['data'];

      return {
        'title': videoData['video_name'] ?? 'No Title',
        'thumbnail':
            '${'https://img.youtube.com/vi/' + videoData['youtube_video_id']}/default.jpg' ??
                'https://img.youtube.com/vi/Bz43NXEYjc8/default.jpg',
        'video_id': videoData['video_id'].toString() ?? '',
      };
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchPlaylistData(page: _currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを消す
      ),
      body: Column(
        children: [
          // ページの説明欄を追加
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'トレンドの試合を表示しています。気になる試合は右端のボタンを押すことで「保存済み」にコピーできます。',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          // 動画リスト
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: videoList.length + 1,
              itemBuilder: (context, index) {
                if (index == videoList.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }
                final video = videoList[index];
                final title = video['title'] ?? 'No Title';
                final thumbnailUrl = video['thumbnail'] ??
                    'https://img.youtube.com/vi/Bz43NXEYjc8/default.jpg';
                final videoId = video['video_id'] ?? '';

                return VideoListItem(
                  key: ValueKey(index), // ユニークなキーを指定
                  title: title,
                  thumbnailUrl: thumbnailUrl,
                  videoId: videoId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String videoId;

  const VideoListItem({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.videoId,
  });

  Future<void> importVideo(BuildContext context) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $globalToken'
      };
      var response = await Dio().post(
        'http://api.made-by-free.com/mcheads/video.php?mode=import&video_id=$videoId',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('動画が正常にインポートされました')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('動画のインポートに失敗しました')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('API request failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // サムネイル画像
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              thumbnailUrl,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // タイトル & 説明
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // インポートボタン
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => importVideo(context),
          ),
        ],
      ),
    );
  }
}
