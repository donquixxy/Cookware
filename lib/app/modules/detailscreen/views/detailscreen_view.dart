import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';

import 'package:get/get.dart';

import '../controllers/detailscreen_controller.dart';

class DetailscreenView extends GetView<DetailscreenController> {
  @override
  Widget build(BuildContext context) {
    Recipes resep = Get.arguments[0];
    String documentId = Get.arguments[1];
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var descRecipes = resep.description;
    List splittedDesc = descRecipes.split('.');

    var textStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black45,
      height: 0.85,
      overflow: TextOverflow.ellipsis,
    );

    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.35,
          child: CachedNetworkImage(
            imageUrl: resep.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  controller.addLikedIdToDB(
                      docId: documentId,
                      currentUserId: controller.firebaseAuth.currentUser!.uid);
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.pink,
                )),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.3),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30),
                  child: Text(
                    resep.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Chip(
                              backgroundColor: Colors.green[200],
                              avatar: CircleAvatar(
                                backgroundColor: Colors.green.withOpacity(0.5),
                                child: const Icon(Icons.timer),
                              ),
                              label: Text(
                                resep.cookTime,
                                style: TextStyle(color: Colors.green.shade900),
                              )),
                          const SizedBox(
                            width: 50,
                          ),
                          Chip(
                              backgroundColor: Colors.red.shade200,
                              avatar: CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.5),
                                child: const Icon(Icons.person),
                              ),
                              label: Text(
                                resep.recipeBy,
                                style: TextStyle(color: Colors.red.shade900),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 3),
                child: Text(
                  "Ingredients :",
                  style: TextStyle(fontSize: 23),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: resep.listIngredients.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 15,
                            color: Colors.amber.shade400,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              resep.listIngredients[index],
                              style: textStyle,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 25),
                child: Text(
                  "Deskripsi :",
                  style: TextStyle(fontSize: 23),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: splittedDesc.length,
                itemBuilder: (context, index) {
                  var indexx = 1 + index;
                  return Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 10),
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                indexx.toString(),
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const VerticalDivider(
                                width: 15,
                                color: Colors.green,
                                thickness: 2,
                              ),
                              Expanded(
                                child: Text(splittedDesc[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 100,
                                    style: textStyle),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ])),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(splittedDesc);
      //   },
      // ),
    );
  }
}
