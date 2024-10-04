 import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

Widget nativeAd(String id) {
    return FacebookNativeAd(
      placementId: id,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 250,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
     
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }