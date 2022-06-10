import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchController());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('SearchView'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.searchTextController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        // controller.searchRecipeByKeywords(
                        //     controller.searchTextController.text,
                        //     controller.listSearched);
                        controller.lister.clear();
                        controller.searchByName(
                            controller.searchTextController.text,
                            controller.lister);
                      },
                      icon: const Icon(Icons.search)),
                  border: const OutlineInputBorder(),
                  labelText: 'Cari resep . . .'),
            ),
            Obx(
              (() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.lister.length,
                  itemBuilder: (context, index) {
                    // String key =
                    //     controller.listOfMappedResep.keys.elementAt(index);
                    return InkWell(
                      onTap: () {
                        controller.showPopUp(arguments: [
                          controller.lister[index],
                          controller.lister[index].id.trim()
                        ], docId: controller.lister[index].id.trim());
                      },
                      child: Card(
                        elevation: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Image Section
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                controller.lister[index].imageUrl,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            //End of Image Section

                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.lister[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "by ${controller.lister[index].recipeBy}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.timer_sharp,
                                            size: 18,
                                            color: greenColor,
                                          ),
                                          Text(
                                              controller.lister[index].cookTime)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                    // return Text(controller.listOfMappedResep[index].name);
                  })),
            )
          ],
        ),
      ),
    );
  }
}
