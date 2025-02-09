import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//プラットホームごとのテスト広告IDを取得するメソッド
String getTestAdBannerUnitId() {
  String testBannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    testBannerUnitId = "ca-app-pub-4369743565857604/9072905814";
  } else if (Platform.isIOS) {
    // iOSのとき
    //testBannerUnitId = "ca-app-pub-3940256099942544/2934735716";
  }
  return testBannerUnitId;
}
//プラットホームごとの広告IDを取得するメソッド
String getAdBannerUnitId() {
  String bannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    bannerUnitId = "ca-app-pub-";
  } else if (Platform.isIOS) {
    // iOSのとき
    bannerUnitId = "ca-app-pub-";
  }
  return bannerUnitId;
}
class AdmobHelper {
  //初期化処理
  static initialization() {
    
  }
  //バナー広告を初期化する処理
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
      adUnitId: getTestAdBannerUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdClosed: (Ad ad) {
          print('ad dispose.');
          ad.dispose();
        },
      ),
    );
    return bAd;
  }
  //ラージサイズのバナー広告を初期化する処理
  static BannerAd getLargeBannerAd() {
    BannerAd bAd = BannerAd(
      adUnitId: getTestAdBannerUnitId(),
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdClosed: (Ad ad) {
          print('ad dispose.');
          ad.dispose();
        },
      ),
    );
    return bAd;
  }
}