import 'package:flutter/material.dart';
import 'playlist.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> futurePlaylists;
  List<Product> demoProducts = [];

  @override
  void initState() {
    super.initState();
    futurePlaylists = get_playlists();
  }

  Future<List<dynamic>> get_playlists() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer MBFSRV'
      };
      var data = {'fsdfasfsaf': 'fsdfsad', 'sdafasf': 'sfsaf'};
      var response = await Dio().request(
        'http://api.made-by-free.com/mcheads/playlist.php?mode=list',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      List<dynamic> playlistData = response.data['data'];
      print(playlistData);

      return response.data['data'];
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを消す
        title: const Text("MCヘッズ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      //bottomNavigationBar: const BottomNavScreen(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        // FutureBuilderを追加
                        future: futurePlaylists, // 非同期処理を渡す
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator()); // ローディング表示
                          } else if (snapshot.hasError) {
                            return Center(
                                child:
                                    Text('Error: ${snapshot.error}')); // エラー表示
                          } else if (snapshot.hasData) {
                            // データが取得できた場合の処理
                            Map<String, dynamic> playlists = {};
                            for (var item in snapshot.data!) {
                              playlists[item['playlist_id']] = item;
                            }
                            demoProducts = parseProducts(playlists);

                            return GridView.builder(
                              itemCount: demoProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 16,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: demoProducts[index],
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistScreen(
                                        playlistId: demoProducts[index].id, playlistName: demoProducts[index].title, playlistThumbnail: demoProducts[index].images[0],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text('No data')); // データがない場合の表示
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  });

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        //SizedBoxで画像サイズを調整
        width: 200,
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // Containerで画像サイズを調整
                width: double.infinity, // 幅を親ウィジェットに合わせる
                height: double.infinity, // 高さを親ウィジェットに合わせる
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(product.images[0]),
                    fit: BoxFit.cover, // 画像の表示方法を指定
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final List<Color> colors;
  final String title;
  final List<String> images;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    required this.title,
  });

  // Factory constructor to create a Product from a map
  factory Product.fromJson(Map<String, dynamic> json) {
    String thumbnaiId =
        json['thumbnail'] ?? ""; // Get the thumbnail or empty string

    // Construct the YouTube image URL if thumbnail is not empty
    String youtubeImageUrl = thumbnaiId.isNotEmpty
        ? "https://img.youtube.com/vi/$thumbnaiId/default.jpg"
        : ""; // If thumbnail is empty, youtubeImageUrl will also be empty

    return Product(
      id: int.parse(
          json['playlist_id'] ?? "0"), // Assuming playlist_id is the ID
      images: thumbnaiId.isNotEmpty
          ? [youtubeImageUrl]
          : [], // Use thumbnail as the image URL
      colors: [
        const Color(0xFFF6625E),
        const Color(0xFF836DB8),
        const Color(0xFFDECB9C),
        Colors.white
      ], // default colors
      title: json['playlist_name'] ?? "", // Use playlist_name as the title
    );
  }
}

List<Product> parseProducts(Map<String, dynamic> jsonData) {
  //jsonDataは、 {"playlist_1": {...}, "playlist_2": {...}}のようなJSONオブジェクトを想定
  List<Product> productList = [];
  //mapのキーと値でループする。
  jsonData.forEach((key, value) {
    //値がマップであることを確認する。
    if (value is Map<String, dynamic>) {
      //jsonオブジェクトはProductに変換する
      productList.add(Product.fromJson(value));
    }
  });
  return productList;
}
