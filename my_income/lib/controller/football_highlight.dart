import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data_model/football_highlight.dart';
import '../data_service/data_service.dart';
import '../utils/apistatus.dart';
import '../utils/constants.dart';

class HighlightController extends GetxController {
  final DataService _dataService = Get.find();
  Rx<HighlightState> highlightstate = HighlightState().obs;

  @override
  void onInit() {
    highlightfetch();
    super.onInit();
  }

  void highlightfetch() {
    highlightstate.value = HighlightLoading();
    _dataService
        .getMatch(
            '${Utils.appUrl}hightlight_api/main/${GetStorage().read(Utils.passwordKey)}')
        .then((value) {
      if (value is Success) {
        var data = jsonDecode(value.response as String) as List;

        List<HighlightModel> model =
            data.map((e) => HighlightModel.fromJson(e)).toList();

        highlightstate.value = HighlighSuccess(model);
      }
      if (value is Failure) {
        highlightstate.value = HighlightFailture(value.response.toString());
      }
    }).catchError((e) {
      highlightstate.value = HighlightFailture(e.toString());
    });
  }
}

class HighlightState {}

class HighlightLoading extends HighlightState {}

class HighlighSuccess extends HighlightState {
  final List<HighlightModel> model;
  HighlighSuccess(this.model);
}

class HighlightFailture extends HighlightState {
  final String message;
  HighlightFailture(this.message);
}
