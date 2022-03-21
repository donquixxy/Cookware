import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/detailscreen_controller.dart';

class DetailscreenView extends GetView<DetailscreenController> {
  Recipes resep = Get.arguments[0];
  var appBar2 = AppBar(
    title: const Text('DetailscreenView'),
    centerTitle: true,
  );
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var paddingTop = MediaQuery.of(context).padding.top;
    var heightBody = screenHeight - paddingTop - appBar2.preferredSize.height;
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
        Container(
          width: screenWidth,
          height: screenHeight * 0.35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(resep.imageUrl), fit: BoxFit.cover)),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
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
              Container(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        resep.name,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ))),
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
              Container(
                child: ListView.builder(
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
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16),
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
                ),
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
