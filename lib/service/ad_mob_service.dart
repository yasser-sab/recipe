import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static bool isDebug = false;
  // static bool isLoaded = false;
  static String? get bannerAdUnitId {
    if (isDebug) {
      return "ca-app-pub-3940256099942544/6300978111";
    }
    if (Platform.isAndroid) {
      return "ca-app-pub-9087033163533723/6823489020";
    } else if (Platform.isIOS) {
      return "";
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (isDebug) {
      return "ca-app-pub-3940256099942544/1033173712";
    }
    if (Platform.isAndroid) {
      return "ca-app-pub-9087033163533723/9768366500";
    } else if (Platform.isIOS) {
      return "";
    }
    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) {
      // AdMobService.isLoaded = true;
      debugPrint('loanded banner');
    },
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("error");
    },
    onAdOpened: (ad) {},
    onAdClosed: (ad) {
      debugPrint('banner disposed');
      ad.dispose();
    },
  );

  static Widget createBanner(AdSize size) {
    // isLoaded = false;
    BannerAd banner = new BannerAd(
      size: size,
      adUnitId: AdMobService.bannerAdUnitId.toString(),
      listener: AdMobService.bannerListener,
      request: AdRequest(),
    )..load();
    // // // print(AdMobService.isLoaded);
    return Container(
      height: banner.size.height.toDouble(),
      width: banner.size.width.toDouble(),
      child: AdWidget(ad: banner),
    );

    // return Container(
    //   color: Colors.transparent,
    //   height: 1,
    // );
  }

  static InterstitialAd createInterstitial() {
    late InterstitialAd interstitial;
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId.toString(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitial = ad;
          // print("loaded");
          // isLoaded = true;
        },
        onAdFailedToLoad: (err) {
          interstitial.dispose();
          debugPrint("error");
        },
      ),
      request: AdRequest(),
    );

    return interstitial;
  }
}
