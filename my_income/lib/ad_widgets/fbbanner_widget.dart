import 'package:facebook_audience_network/facebook_audience_network.dart';

class FacebookBanner {
  showBanner(String id) {
   return FacebookBannerAd(
      placementId:id,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            break;
          case BannerAdResult.LOADED:
         
            break;
          case BannerAdResult.CLICKED:
           
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
          
            break;
        }
      },
    );
  }
}
