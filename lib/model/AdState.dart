import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get banneradunit => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';
  AdListener get adListener => _adListener;

  AdListener _adListener = AdListener(
      onAdLoaded: (ad) => print('Ad loaded:${ad.adUnitId}'),
      onAdClosed: (ad) => print('Ad closed:${ad.adUnitId}'),
      onAdFailedToLoad: (ad, error) =>
          print('Ad Failed to load ${ad.adUnitId},$error'),
      onAdOpened: (ad) => print('Ad opened ${ad.adUnitId}'),
      onAppEvent: (ad, name, data) =>
          print('App event :${ad.adUnitId},$name,$data'),
      onApplicationExit: (ad) => print('App Exit ${ad.adUnitId}'),
      onNativeAdClicked: (nativeAd) => print('App Exit:${nativeAd.adUnitId}'),
      onNativeAdImpression: (nativeAd) =>
          print('Native ad impression:${nativeAd.adUnitId}'));
}
