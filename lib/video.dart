import 'package:flutter/material.dart';

class VideoEditPage extends StatelessWidget {
  final String thumbnailUrl = 'https://img.youtube.com/vi/FmeJHifdXgE/default.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('動画編集ページ'),
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
                onPressed: () {
                  // 動画を削除する処理
                },
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



