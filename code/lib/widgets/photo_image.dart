import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

void openFullImage(String url) {
  Get.to(Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () => Get.back(),
      child: Icon(
        Icons.close,
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: PhotoView(
      imageProvider: NetworkImage(url),
    ),
  ));
}
