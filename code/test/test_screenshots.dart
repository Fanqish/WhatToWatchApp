import 'dart:math';
import 'dart:convert';
import 'dart:io';
import '../lib/consts/global.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

void main() async {
  String randomizeTVMovie = Random().nextBool() ? "movie" : "tv";

  String requestRandomMovieTV =
      "https://api.themoviedb.org/3/discover/$randomizeTVMovie?api_key=d8d321f34976f15bf821ff5fa09c88bc&sort_by=popularity.desc&include_adult=false&page=${Random().nextInt(500)}";

  var random = await json.decode(
          ((await http.get(Uri.parse(requestRandomMovieTV)))).body)["results"]
      [Random().nextInt(20)];

  print("randomhere");
  downloadFile(
      anyImgUrl + random["poster_path"],
      random["id"] + random["poster_path"].toString().split(".")[1],
      Directory.current.path);
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';

  try {
    myUrl = url;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    print(request);
    var response = await request.close();
    if (response.statusCode == 200) {
      print("Here");
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = 'Error code: ' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return filePath;
}
