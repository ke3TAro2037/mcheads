import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance; // シングルトンインスタンスを返す

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://ke3taro2037.m31.coreserver.jp/mcheads',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        //String? apiKey = await FlutterSecureStorage().read(key: 'token'); // SecureStorage からAPIキーを取得
        String apiKey = 'MBFSRV';
        options.headers['Authorization'] = 'Bearer $apiKey'; // 認証ヘッダーを追加
      
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // 成功レスポンスをそのまま流す
      },
      onError: (DioException e, handler) {
        return handler.next(e); // エラー処理を追加する場合はここで対応
      },
    ));
    
    Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      rethrow; // エラーを上位に投げる
    }
  }
  }

  
}

