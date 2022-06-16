import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/resep_provider_controller.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  // final usersController = Get.put(UsersControllerController());

  @override
  Widget build(BuildContext context) {
    // var foreGroundColor = controller.backGroundColor.computeLuminance() > 0.6
    //     ? Colors.black87
    //     : Colors.white70;
    var resepController = Get.put(ResepProviderController());
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => RefreshIndicator(
          onRefresh: resepController.streamDataOnDb,
          child: SingleChildScrollView(
            // Header Section

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'Halo Bunda,',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 8),
                    child: Text(
                      'Mau masak apa hari ini ?',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),

                  //End Of Header Section

                  // Slider Section
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
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
                      items: resepController.data1
                          .map((data) => GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.DETAILSCREEN,
                                      arguments: [data, data.id]);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    ClipRRect(
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            imageUrl: data.imageUrl,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            // fit: BoxFit.cover,
                                            // width: double.infinity,
                                            // image: data.imageUrl,
                                            // placeholder:
                                            //     'assets/placeholder.jpg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: SizedBox(
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            data.name,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                shadows: [
                                                  Shadow(
                                                      blurRadius: 3,
                                                      color: Colors.black),
                                                  Shadow(
                                                      blurRadius: 3,
                                                      color: Colors.black)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
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

                  // End Of Slider

                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 130,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: greenColor,
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
                            color: greenColor,
                          ),
                        )
                      ],
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

                    // Body Section

                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 280,
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: resepController.data1.length,
                      itemBuilder: (context, index) {
                        // var _data = snapshot.data!.docs[index].data()
                        //     as Map<String, dynamic>;
                        Recipes dataResep = resepController.data1[index];
                        // String docId = snapshot.data!.docs[index].id;
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAILSCREEN,
                                arguments: [dataResep, dataResep.id]);
                          },
                          child: SizedBox(
                            height: double.infinity,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // physics:
                                //     NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: dataResep.imageUrl,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorWidget: (context, url, widget) =>
                                          const Icon(Icons.error,
                                              color: Colors.red),
                                      placeholder: (context, url) =>
                                          Image.asset('assets/placeholder.jpg'),
                                      // height: 150,
                                      // fit: BoxFit.cover,
                                      // width: double.infinity,
                                      // image: dataResep.imageUrl,
                                      // placeholder:
                                      //     'assets/placeholder.jpg',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Text(
                                      dataResep.name,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15, top: 5),
                                    child: Text(
                                      'By ${dataResep.recipeBy}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.only(left: 12, top: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.timer_outlined,
                                          color:
                                              Color.fromARGB(255, 4, 147, 114),
                                        ),
                                        Text(
                                          dataResep.cookTime,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // End Of Body section
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
