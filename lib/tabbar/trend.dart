import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:myapp/home.dart';
import 'package:myapp/main.dart';

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
      body: ListView.builder(
        controller: _scrollController,
        itemCount: videoList.length + 1,
        itemBuilder: (context, index) {
          if (index == videoList.length) {
            return _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink();
          }
          final video = videoList[index];
          return VideoListItem(
            key: ValueKey(index), // ユニークなキーを指定
            title: video['title']!,
            thumbnailUrl: video['thumbnail']!,
          );
        },
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String title;
  final String thumbnailUrl;

  const VideoListItem({
    super.key,
    required this.title,
    required this.thumbnailUrl,
  });

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
        ],
      ),
    );
  }
}