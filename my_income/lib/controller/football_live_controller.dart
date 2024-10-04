import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data_model/football_live_model.dart';
import '../data_service/data_service.dart';
import '../utils/apistatus.dart';
import '../utils/constants.dart';

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  final DataService _dataService = Get.find();
  Rx<DataState> dataState = DataState().obs;
  @override
  void onInit() {
    fetchdata();

    super.onInit();
  }

  void fetchdata() {
    isLoading.value = true;
    dataState.value = DataLoading();
    _dataService
        .getMatch(
            '${Utils.appUrl}live_api/main/${GetStorage().read(Utils.passwordKey)}')
        .then((value) {
      if (value is Success) {
        var footballlive = dataModelFromJson(value.response as String);
        dataState.value = DataSuccess(footballlive);
      }
      if (value is Failure) {
        dataState.value = DataFailture(value.response.toString());
      }
    }).catchError((e) {
      DataFailture(e.toString());
    });
    isLoading.value = false;
  }
}

class DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final DataModel model;
  DataSuccess(this.model);
}

class DataFailture extends DataState {
  String message;
  DataFailture(this.message);
}
