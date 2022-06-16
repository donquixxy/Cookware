import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BookmarkController());
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.streamUserBookmarkData(
            currentuid: controller.firebaseCurrentUser!.uid),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: greenColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Favorites",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Divider(
                            height: 20,
                            thickness: 3,
                            color: greenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      controller.streamUserBookmarkData(
                          currentuid: controller.firebaseCurrentUser!.uid);
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        var docId = snapshot.data!.docs[index].id;
                        Recipes resepData = Recipes.fromJson(_data);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAILSCREEN,
                                arguments: [resepData, docId]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Image Section
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: resepData.imageUrl,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  //End of Image Section

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                resepData.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "by ${resepData.recipeBy}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_sharp,
                                                  size: 18,
                                                  color: greenColor,
                                                ),
                                                Text(resepData.cookTime)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.deleteFromBookmark(
                                              docId,
                                              controller
                                                  .firebaseCurrentUser!.uid);
                                        },
                                        icon: const Icon(Icons.bookmark,
                                            color: greenColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
