import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../data_service/data_service.dart';
import '../utils/apistatus.dart';
import '../utils/constants.dart';

enum ConnectionStatus { loading, connected, diconnected }

class NetworkController extends GetxController {
  Rx<ConnectionStatus> status = ConnectionStatus.loading.obs;
  RxInt count = 0.obs;
  RxBool isLoading = true.obs;
  var con = false.obs;
  var title = ''.obs;
  var subtitle = ''.obs;
  RxDouble uriversion = 0.0.obs;
  var uriversionDetails = ''.obs;
  var link = ''.obs;

  @override
  void onInit() {
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen(checkStatus);
    super.onInit();
  }

  void changeNavigation(int index) {
    count.value = index;
    update();
  }

  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    checkStatus(connectivityResult);
  }

  void checkStatus(ConnectivityResult result) async {
    status.value = ConnectionStatus.loading;
    if (result == ConnectivityResult.none) {
      status.value = ConnectionStatus.diconnected;
    } else {
      status.value = ConnectionStatus.connected;
      await DataService().getMatch('${Utils.appUrl}app_version/main/app_controller').then((value) {
        if (value is Success) {
          isLoading.value = false;
          var data = value.response as String;
          var decode = jsonDecode(data);
          con.value = decode['con'];
          title.value = decode['title'];
          subtitle.value = decode['subtitle'];
          uriversion.value = double.parse( decode['uriversion']);
          uriversionDetails.value = decode['uriversionDetails'];
          link.value = decode['link'];
        }
      });
    }
  }
}
