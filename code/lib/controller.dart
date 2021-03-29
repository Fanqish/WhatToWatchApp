import 'dart:math';
import 'package:get/get.dart';
import 'models/show_model.dart';
import 'utils/online.dart';

class AppController extends GetxController {
  // Main Vals
  Rx<Show> nowShow = Show().obs;
  RxList watchLater = <Show>[].obs;
  Rx screenshots;
  // Techinical Vals
  RxBool ready = false.obs;
  RxBool internet = true.obs;
  RxBool found = false.obs;

  void getShow() async {
    ready.value = false;
    // checkInternet();
    String randomizeTVMovie = Random().nextBool() ? "movie" : "tv";

    String requestRandomMovieTV =
        "https://api.themoviedb.org/3/discover/$randomizeTVMovie?api_key=d8d321f34976f15bf821ff5fa09c88bc&sort_by=popularity.desc&include_adult=false&page=${Random().nextInt(500)}";

    var random = await ((await GetConnect().get(requestRandomMovieTV))
        ?.body)["results"][Random().nextInt(20)];

    // String requestScreenshots =
    //     "https://api.themoviedb.org/3/$randomizeTVMovie/${random["id"]}/images?api_key=d8d321f34976f15bf821ff5fa09c88bc";
    print(random);
    print(random["name"] ?? random["title"]);
    nowShow(Show(
        id: random["id"],
        title: random["title"] ??
            random["name"] ??
            random["original_name"] ??
            random["original_name"],
        genres: random["gernes"],
        rate: random["vote_average"] ?? 0.0,
        poster: ("https://www.themoviedb.org/t/p/w500" +
                random["poster_path"]) ??
            "https://upload.wikimedia.org/wikipedia/commons/f/fc/No_picture_available.png",
        backdrop: ("https://www.themoviedb.org/t/p/w500" +
                random["backdrop_path"]) ??
            "https://upload.wikimedia.org/wikipedia/commons/f/fc/No_picture_available.png",
        overview: random["overview"] != null || random["overview"] != ""
            ? random["overview"]
            : "Show Description Not Found"));
    checkBookmark();
    ready.value = true;
  }

  void bookmarking() {
    found.value
        ? watchLater.remove(nowShow.value)
        : watchLater.add(nowShow.value);
    checkBookmark();
  }

  void checkBookmark() {
    found.value = false;
    if (watchLater.isNotEmpty) {
      watchLater.forEach((element) {
        if (element == nowShow.value) found.value = true;
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
