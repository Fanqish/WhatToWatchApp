// import 'package:code/consts/themes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:code/controller.dart';
import 'package:code/widgets/photo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WatchLaterView extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.watchLater.isEmpty
          ? FadeIn(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_rounded,
                      size: 150,
                      color: Get.isDarkMode
                          ? Colors.white
                          : context.theme.accentColor),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                        child: AutoSizeText(
                      "Click On Bookmark Button In Home Screen To Save Movies / TV Show In Your Watch Later Collection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  )
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  itemCount: controller.watchLater.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => openFullImage(
                                  controller.watchLater[index].poster),
                              child: Expanded(
                                child: Container(
                                  height: Get.context.height * .33,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    controller.watchLater[index].poster,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress != null)
                                        return Expanded(
                                          child: Container(),
                                        );
                                      return FadeIn(
                                        duration: 1.seconds,
                                        child: child,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        controller.watchLater[index].title,
                                        minFontSize: 25.0,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    SmoothStarRating(
                                      rating:
                                          controller.watchLater[index].rate / 2,
                                      color: Get.context.theme.accentColor,
                                      isReadOnly: true,
                                      borderColor:
                                          Get.context.theme.accentColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              color: Get.context.theme.accentColor,
                              icon: Icon(Icons.delete),
                              iconSize: 35,
                              onPressed: () {
                                print("delete");
                                controller.watchLater.removeAt(index);
                                controller.checkBookmark();
                              },
                            )
                          ]),
                    );
                  }),
            ),
    );
  }
}
