// import 'package:code/consts/themes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:code/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WatchLaterView extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          itemCount: controller.watchLater.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: Get.context.height * .33,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                        controller.watchLater[index].poster,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AutoSizeText(
                              controller.watchLater[index].title,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SmoothStarRating(
                              rating: controller.watchLater[index].rate / 2,
                              color: Get.context.theme.accentColor,
                              isReadOnly: true,
                              borderColor: Get.context.theme.accentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      color: Get.context.theme.accentColor,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.watchLater.removeAt(index);
                        controller.checkBookmark();
                      },
                    )
                  ]),
            );
          }),
    );
  }
}
