import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data_model/ads_model.dart';
import '../utils/constants.dart';

class AdsController extends GetxController {
  RxBool adsStatus = false.obs;
  RxString fbbanner = ''.obs;
  RxString fbinterstitial = ''.obs;
  RxString fbnative = ''.obs;
  RxString fbreward = ''.obs;

  @override
  void onInit() {
    fetchAds();
    super.onInit();
  }

  Future<AdsModel?> fetchAds() async {
    try {
      Uri uri = Uri.parse('${Utils.appUrl}ads_controller/main/ads');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var adsData = adsModelFromJson(response.body);
        fbbanner.value = adsData.banner;
        fbinterstitial.value = adsData.interstrital;
        fbnative.value = adsData.native;
        fbreward.value = adsData.videoads;
        adsStatus.value = adsData.status;
        return adsData;
      } else {
        // Handle non-200 response
        Get.snackbar(
          'Error',
          'Failed to fetch ads. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return null; // Return null or a default AdsModel if needed
      }
    } catch (e) {
      // Handle exception and show snackbar
      Get.snackbar(
        'Error',
        'An error occurred while fetching ads: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null; // Return null or a default AdsModel if needed
    }
  }
}
