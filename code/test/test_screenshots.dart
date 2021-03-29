import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

void main() async {
  String randomizeTVMovie = Random().nextBool() ? "movie" : "tv";

  String requestRandomMovieTV =
      "https://api.themoviedb.org/3/discover/$randomizeTVMovie?api_key=d8d321f34976f15bf821ff5fa09c88bc&sort_by=popularity.desc&include_adult=false&page=${Random().nextInt(500)}";

  var random = await json.decode(
          ((await get(Uri.parse(requestRandomMovieTV)))).body)["results"]
      [Random().nextInt(20)];

  String requestScreenshots =
      "https://api.themoviedb.org/3/$randomizeTVMovie/${random["id"]}/images?api_key=d8d321f34976f15bf821ff5fa09c88bc";

  List screenshots = await jsonDecode(
      ((await get(Uri.parse(requestScreenshots)))).body)["backdrops"];
  screenshots.forEach((element) {
    print(element["file_path"]);
  });
}
