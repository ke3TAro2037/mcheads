import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class VideoEditPage extends StatefulWidget {
  final String videoId;

  VideoEditPage({super.key, required this.videoId});

  @override
  _VideoEditPageState createState() => _VideoEditPageState();
}

class _VideoEditPageState extends State<VideoEditPage> {
  String thumbnailUrl = 'https://img.youtube.com/vi/FmeJHifdXgE/default.jpg';
  String videoTitle = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchVideoDetails(int.parse(widget.videoId)).then((details) {
      setState(() {
        thumbnailUrl = details?['thumbnail'] ?? thumbnailUrl;
        videoTitle = details?['title'] ?? videoTitle;
      });
    });
  }

  Future<void> deleteVideo() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $globalToken'
      };
      var response = await Dio().delete(
        'http://api.made-by-free.com/mcheads/video.php',
        data: {'video_id': widget.videoId},
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('動画が削除されました')),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to delete video');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('動画の削除に失敗しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 動画のサムネイル
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 歌詞を選択するドロップダウンボタン
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: '歌詞を選択',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: <String>['歌詞1', '歌詞2', '歌詞3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // 歌詞が選択されたときの処理
                },
              ),
              SizedBox(height: 16),
              // 他のユーザーが作った歌詞をインポートするボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 別ページに移動して歌詞をインポートする処理
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImportLyricsPage()),
                  );
                },
                icon: Icon(Icons.import_export),
                label: Text('他のユーザーが作った歌詞をインポート'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 新しく歌詞の作成を開始するボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 新しい歌詞の作成を開始する処理
                },
                icon: Icon(Icons.create),
                label: Text('新しく歌詞の作成を開始'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 既存の歌詞の編集を開始するボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 既存の歌詞の編集を開始する処理
                },
                icon: Icon(Icons.edit),
                label: Text('既存の歌詞の編集を開始'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 動画を削除するボタン
              ElevatedButton.icon(
                onPressed: deleteVideo,
                icon: Icon(Icons.delete),
                label: Text('動画を削除'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 動画のカット編集を開始するボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 動画のカット編集を開始する処理
                },
                icon: Icon(Icons.cut),
                label: Text('動画のカット編集を開始'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImportLyricsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歌詞をインポート'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('歌詞1'),
            onTap: () {
              // 歌詞1をインポートする処理
            },
          ),
          ListTile(
            title: Text('歌詞2'),
            onTap: () {
              // 歌詞2をインポートする処理
            },
          ),
          ListTile(
            title: Text('歌詞3'),
            onTap: () {
              // 歌詞3をインポートする処理
            },
          ),
        ],
      ),
    );
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
