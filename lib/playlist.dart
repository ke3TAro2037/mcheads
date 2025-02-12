
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'nav.dart';

class PlaylistScreen extends StatefulWidget {
  final int playlistId;
  final String playlistName;
  final String playlistThumbnail;

  Future<List<dynamic>> get_videos() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?mode=detail&playlist_id=1',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      List<dynamic>
 playlistData = response.data['data'];
      print(playlistData);

      return response.data['data'];
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  const PlaylistScreen(
      {super.key,
      required this.playlistId,
      required this.playlistName,
      required this.playlistThumbnail});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late List<Map<String, String>> videoList;
  late List<int> videoIdInts = []; //動画idを管理するList
  late String currentPlaylistName; // 現在のプレイリスト名を保持する

  @override
  void initState() {
    super.initState();
    currentPlaylistName = widget.playlistName; // 初期化時に現在の名前を設定
    fetchPlaylistData();
  }

  Future<void> fetchPlaylistData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?mode=detail&playlist_id=${widget.playlistId}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      print(response.data);

      final Map<String, dynamic> jsonData = response.data;
      if (jsonData['status'] == 200 && jsonData['data'] != null) {
        final playlistData = jsonData['data'];
        final String videosString = playlistData['videos'];
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
          videoList = fetchedVideos;
        });
      } else {
        print('API request failed: ${response.statusCode}');
        // エラー処理
      }
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  Future<Map<String, String>?> fetchVideoDetails(int videoId) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/video.php?video_id=$videoId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      print(response.data);
      final Map<String, dynamic> videoData = response.data['data'];

      return {
        'title': videoData['video_name'] ?? 'No Title',
        'thumbnail':
            '${'https://img.youtube.com/vi/' + videoData['youtube_video_id']}/default.jpg' ??
                'https://img.youtube.com/vi/Bz43NXEYjc8/default.jpg', // デフォルトのサムネイル
      };
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  //動画の並び順を更新する処理
  Future<void> updatePlaylistOrder(List<int> newOrder) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      // APIに渡すデータを整形
      var data = {'videos': newOrder};

      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?playlist_videos=1&playlist_id=${widget.playlistId}',
        options: Options(
          method: 'PUT', // PUTメソッドを使用
          headers: headers,
        ),
        data: data, // 整形したデータを送信
      );

      if (response.statusCode == 200) {
        print('Playlist order updated successfully');
      } else {
        print('Failed to update playlist order');
      }
    } catch (e) {
      print('Error updating playlist order: $e');
    }
  }

  // プレイリスト名を更新するAPIを呼び出す関数
  Future<void> updatePlaylistName(String newName) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?playlist_name=$newName&playlist_id=${widget.playlistId}',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print('Playlist name updated successfully');
        setState(() {
          currentPlaylistName = newName; // 状態を更新
        });
      } else {
        print('Failed to update playlist name');
      }
    } catch (e) {
      print('Error updating playlist name: $e');
    }
  }

  // プレイリストを削除するAPIを呼び出す関数
  Future<void> deletePlaylist() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };

      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?playlist_id=${widget.playlistId}',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print('Playlist deleted successfully');
        // TODO: プレイリスト一覧画面に戻るなどの処理を追加
        // 遷移処理を追加
        Navigator.pop(context); // 現在の画面を閉じる
      } else {
        print('Failed to delete playlist');
      }
    } catch (e) {
      print('Error deleting playlist: $e');
    }
  }

  // 編集ポップアップを表示する関数
  void _showEditPopup(BuildContext context) {
    String newName = currentPlaylistName; // 入力フィールドの初期値を設定
    showDialog(
      context: context,
      builder: (BuildContext context
) {
        return AlertDialog(
          title: const Text('プレイリストの編集'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(hintText: '新しいプレイリスト名'),
                onChanged: (value) {
                  newName = value;
                },
                controller: TextEditingController(text: newName),
              ),
              ElevatedButton(
                onPressed: () {
                  updatePlaylistName(newName);
                  Navigator.of(context).pop();
                },
                child: const Text('更新'),
              ),
              ElevatedButton(
                onPressed: () {
                  deletePlaylist();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // ボタンの背景色を赤に設定
                ),
                child: const Text('プレイリストを削除',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0), // AppBarの高さを200pxに設定
        child: AppBar(
          title: Row(
            children: [
              Expanded(child: Text(currentPlaylistName)), // プレイリスト名を左寄せ
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditPopup(context),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.playlistThumbnail), // 画像URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavScreen(),
      body: ReorderableListView(
        // リストアイテムの順番を変更するためのコールバック
        onReorder: (oldIndex, newIndex
) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = videoList.removeAt(oldIndex);
            videoList.insert(newIndex, item);
            //並び替え後のvideoIdIntsを更新する
            final itemId = videoIdInts.removeAt(oldIndex);
            videoIdInts.insert(newIndex, itemId);

            //並び替えられたvideoIdIntsをAPIに送る
            updatePlaylistOrder(videoIdInts);
          });
        },
        children: List.generate(
          videoList.length,
          (index) {
            final video = videoList[index];
            return VideoListItem(
              key: ValueKey(index), // ユニークなキーを指定
              title: video['title']!,
              thumbnailUrl: video['thumbnail']!,
            );
          },
        ),
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
          // 並び替えアイコン（サムネイルの左側）
          IconButton(
            icon: const Icon(
              Icons.drag_handle,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              // ここでは並び替えボタンの処理はしませんが、デザインとして表示
            },
          ),

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
