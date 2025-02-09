import 'package:flutter/material.dart';
import 'nav.dart';


class DraftList extends StatelessWidget {
  final String playlistId;

  // プレイリストごとに異なる動画リストを用意する
  final Map<String, List<Map<String, String>>> playlists = {
    'playlist_1': [
      {
        'title': 'Flutter入門 #1 - まずはセットアップ',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'Flutterアプリ開発の基本を学びましょう！',
      },
      {
        'title': 'Flutter入門 #2 - ウィジェットの基礎',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'ウィジェットの使い方を学びましょう。',
      },
    ],
    'playlist_2': [
      {
        'title': 'Python入門 #1 - Pythonの基本',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'Pythonの基礎を学びます。',
      },
      {
        'title': 'Python入門 #2 - データ構造',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'リスト、タプル、辞書の使い方を学びましょう。',
      },
    ],
    'playlist_3': [
      {
        'title': 'Dart入門 #1 - Dartの基本',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'Dartの基礎を学びます。',
      },
      {
        'title': 'Dart入門 #2 - クラスとオブジェクト',
        'thumbnail': 'https://via.placeholder.com/150',
        'description': 'Dartのクラスの基礎を学びましょう。',
      },
    ],
  };

  DraftList({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context) {
    // playlistId に基づいて動画リストを取得する
    final videoList = playlists[playlistId] ?? [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを消す
        title: const Text('保存した試合'),
      ),

      bottomNavigationBar: const BottomNavScreen(),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          return DraftListItem(
            title: video['title']!,
            thumbnailUrl: video['thumbnail']!,
            description: video['description']!,
          );
        },
      ),
    );
  }
}




class DraftListItem extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String description;

  const DraftListItem({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
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
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}