import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'consts/global.dart';
import 'models/show_model.dart';
import 'screens/home/views/watch_later.dart';
import 'utils/database.dart';
import 'utils/online.dart';

class AppController extends GetxController {
  // Main Vals
  Rx<Show> nowShow = Show().obs;
  List screenshots;
  // Techinical Vals
  RxBool ready = false.obs;
  RxBool internet = true.obs;
  RxBool found = false.obs;

  void getShow() async {
    bool error = false;
    ready.value = false;

    checkInternet();

    String randomizeTVMovie = Random().nextBool() ? "movie" : "tv";
    try {
      var random = await ((await GetConnect().get(
              "https://api.themoviedb.org/3/discover/$randomizeTVMovie?api_key=d8d321f34976f15bf821ff5fa09c88bc&sort_by=popularity.desc&include_adult=false&page=${Random().nextInt(101)}"))
          ?.body)["results"][Random().nextInt(20)];

      screenshots = jsonDecode((await GetConnect().get(
              "https://api.themoviedb.org/3/$randomizeTVMovie/${random["id"]}/images?api_key=d8d321f34976f15bf821ff5fa09c88bc"))
          .bodyString)["backdrops"];

      nowShow(Show(
          id: random["id"],
          title: (random["title"] ??
                  random["name"] ??
                  random["original_name"] ??
                  random["original_name"]) +
              " (" +
              (random["original_language"] != null
                  ? "${random["original_language"]}".toUpperCase()
                  : "") +
              " ${randomizeTVMovie == "movie" ? randomizeTVMovie.capitalize : randomizeTVMovie.toUpperCase()}" +
              ")",
          rate: random["vote_average"] ?? 0.0,
          poster:
              random["poster_path"] != null || random["poster_path"] != "null"
                  ? (anyImgUrl + random["poster_path"])
                  : anyBrokenImgUrl,
          backdrop: random["backdrop_path"] != null ||
                  random["backdrop_path"] != "null"
              ? (anyImgUrl + random["backdrop_path"])
              : anyBrokenImgUrl,
          overview: random["overview"] != null || random["overview"] != "null"
              ? random["overview"]
              : "Show Description Not Found"));
    } catch (e) {
      print(e);
      error = true;
      getShow();
    } finally {
      checkBookmark();
      if (!error) ready.value = true;
    }
  }

  void bookmarking() {
    if (found.value) {
      shows.delete(nowShow.value.id);
    } else {
      shows.put(nowShow.value.id, nowShow.value.toJson());
    }
    checkBookmark();
  }

  void checkBookmark() {
    found.value = false;
    if (shows.isNotEmpty) {
      shows.keys.forEach((element) {
        if (element == nowShow.value.id) found.value = true;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    getShow();
  }
}

class AppControllerBinder implements Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
  }
}
