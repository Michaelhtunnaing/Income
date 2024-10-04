import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MM_TVPro/ad_widgets/fbnative_widget.dart';
import '../ad_widgets/fbbanner_widget.dart';
import '../ad_widgets/fbinterstitial_widget.dart';
import '../controller/ads_controller.dart';

class AdsChange {
  final AdsController adsCheck = Get.find<AdsController>();
  Widget showBanner() {
    if (adsCheck.adsStatus.value) {
      return FacebookBanner().showBanner(adsCheck.fbbanner.value);
    }
    return const SizedBox();
  }

  void showInterstital() {
    if (adsCheck.adsStatus.value) {
      FbInterstitialAd().loadInterstitialAd(adsCheck.fbinterstitial.value);
      FbInterstitialAd().showInterstitial();
    }
  }

  void adInit() {
    if (adsCheck.adsStatus.value) {
      FbInterstitialAd().loadInterstitialAd(adsCheck.fbinterstitial.value);
    }
  }

  Widget fbNative() {
    if (adsCheck.adsStatus.value) {
      return nativeAd(adsCheck.fbnative.value);
    }
    return const SizedBox();
  }
}
