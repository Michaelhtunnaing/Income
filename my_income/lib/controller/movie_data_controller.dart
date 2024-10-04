import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data_model/movie_model.dart';
import '../data_service/data_service.dart';
import '../utils/apistatus.dart';
import '../utils/constants.dart';

class MovieController extends GetxController {
  final DataService _dataService = Get.find();
  Rx<MovieState> moviestate = MovieState().obs;
  @override
  void onInit() {
   
    fetchMovie();
    super.onInit();
  }

  void fetchMovie() async {
    moviestate.value = MovieLoading();
    await _dataService.getMatch('${Utils.appUrl}movie_api/main/${GetStorage().read(Utils.passwordKey)}').then((value) {
      if (value is Success) {
        var movies = movieModelFromJson(value.response as String);
        moviestate.value = MovieSuccess(movies);
      }
      if (value is Failure) {
        MovieFailture(value.response.toString());
      }
    }).catchError((e) {
      MovieFailture(e.toString());
    });
  }
}

class MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final MovieModel model;
  MovieSuccess(this.model);
}

class MovieFailture extends MovieState {
  final String message;
  MovieFailture(this.message);
}
