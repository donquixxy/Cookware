import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  final controller = Get.put(OverviewController());
  final usersController = Get.put(UsersControllerController());
  @override
  Widget build(BuildContext context) {
    var foreGroundColor = controller.backGroundColor.computeLuminance() > 0.6
        ? Colors.black87
        : Colors.white70;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: controller.streamDataOnDb(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Row(
                            //   children: [
                            //     IconButton(
                            //         onPressed: () {
                            //           print(controller.listOfData.length);
                            //           print('ok');
                            //           print(controller.data1);
                            //         },
                            //         icon: const Icon(
                            //           Icons.menu,
                            //           color: Colors.black,
                            //         ))
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                'Halo Bunda,',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 8),
                              child: Text(
                                'Mau masak apa hari ini ?',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ),
                            Container(
                              height: Get.size.height * 0.25,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  reverse: true,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                ),
                                items: controller.listOfData
                                    .map((data) => GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.DETAILSCREEN,
                                                arguments: [data, 'null']);
                                          },
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              ClipRRect(
                                                  // borderRadius: const BorderRadius.only(
                                                  //   bottomLeft: Radius.circular(30),
                                                  //   bottomRight: Radius.circular(30),
                                                  // ),
                                                  child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                    sigmaX: 1, sigmaY: 2),
                                                child: Image.network(
                                                  data.imageUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              )),
                                              Positioned(
                                                  child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.transparent),
                                                child: SizedBox(
                                                  width: 200,
                                                  child: Center(
                                                    child: Text(
                                                      data.name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 3,
                                                                color: Colors
                                                                    .black),
                                                            Shadow(
                                                                blurRadius: 3,
                                                                color: Colors
                                                                    .black)
                                                          ],
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 40),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            //TODO : CATEGORIES..
                            // Container(
                            //   height: 150,
                            //   child: StreamBuilder(
                            //     builder: (context, snapshot) {

                            //       return ListView.builder(
                            //         itemCount:  ,
                            //         itemBuilder: ,
                            //       )
                            //     },
                            //   )
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromARGB(255, 4, 147, 114),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Resep Terbaru",
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
                                        color: Color.fromARGB(255, 4, 147, 114),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                // scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 270,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 4),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var _data = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  Recipes dataResep = Recipes.fromJson(_data);
                                  String docId = snapshot.data!.docs[index].id;
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAILSCREEN,
                                          arguments: [dataResep, docId]);
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.network(
                                                dataResep.imageUrl,
                                                height: 150,
                                                width: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, left: 15),
                                              child: Text(
                                                dataResep.name,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 5),
                                              child: Text(
                                                'By ${dataResep.recipeBy}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 12, top: 5),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.timer_outlined,
                                                    color: Color.fromARGB(
                                                        255, 4, 147, 114),
                                                  ),
                                                  Text(
                                                    dataResep.cookTime,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ]),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
