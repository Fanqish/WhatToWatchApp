import 'package:cached_network_image/cached_network_image.dart';
import 'package:code/models/show_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:code/controller.dart';
import 'package:code/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WatchLaterView extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: shows.listenable(),
      builder: (context, Box box, child) => shows.isEmpty
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
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var theshow = Show.fromJson(box.getAt(index));
                    return Container(
                      margin: EdgeInsets.all(15),
                      child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: Get.context.height * .30,
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                imageUrl: theshow.poster,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        theshow.title,
                                        minFontSize: 20.0,
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
                                      rating: theshow.rate / 2,
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
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Get.context.theme.accentColor,
                              icon: Icon(Icons.delete),
                              iconSize: 30,
                              onPressed: () {
                                shows.delete(theshow.id);
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
