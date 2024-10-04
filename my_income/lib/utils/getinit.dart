import 'package:get/get.dart';
import 'package:MM_TVPro/controller/ads_controller.dart';
import '../controller/network_controller.dart';
import '../controller/theme_controller.dart';
import '../data_service/data_service.dart';

class GetInit extends Bindings {
  @override
  void dependencies() {
    Get.put(AdsController());
    Get.put(DataService());
    Get.put(NetworkController());
    Get.put(ThemeController()).init();
  
  }
}
