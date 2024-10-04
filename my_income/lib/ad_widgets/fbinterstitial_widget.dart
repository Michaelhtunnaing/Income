import 'package:facebook_audience_network/facebook_audience_network.dart';

class FbInterstitialAd {
  void loadInterstitialAd(id) {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: id,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {}

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          loadInterstitialAd(id);
        }
      },
    );
  }

  void showInterstitial() {
    FacebookInterstitialAd.showInterstitialAd();
  }
}
