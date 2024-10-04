import 'package:get/get.dart';
import 'package:MM_TVPro/utils/constants.dart';
import '../data_model/funny_model.dart';
import '../data_service/data_service.dart';
import '../utils/apistatus.dart';

class FunnyDataController extends GetxController {
  final DataService _dataService = Get.find();
  Rx<FunnyDataState> moviestate = FunnyDataState().obs;
  @override
  void onInit() {
   
    fetchMovie();
    super.onInit();
  }

  void fetchMovie() async {
    moviestate.value = FunnyDataLoading();
    await _dataService.getMatch(Utils.previewUrl).then((value) {
      if (value is Success) {
        var movies = previewModelFromJson(value.response as String);
        moviestate.value = FunnyDataSuccess(movies);
      }
      if (value is Failure) {
        FunnyDataFailture(value.response.toString());
      }
    }).catchError((e) {
      FunnyDataFailture(e.toString());
    });
  }
}

class FunnyDataState {}

class FunnyDataLoading extends FunnyDataState {}

class FunnyDataSuccess extends FunnyDataState {
 List< FunnyDataModel> model;
  FunnyDataSuccess(this.model);
}

class FunnyDataFailture extends FunnyDataState {
  final String message;
  FunnyDataFailture(this.message);
}
