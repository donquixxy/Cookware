import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/resep_provider_controller.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  @override
  Widget build(BuildContext context) {
    var usersController = Get.find<UsersControllerController>();
    var myController = Get.put(ResepProviderController());
    var controller = Get.put(AdminPanelController());
    // var controller = Get.lazyPut(
    //   () => ResepProviderController(),
    // );
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: greenColor,
          onPressed: () {
            Get.toNamed(Routes.ADD_DATA);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        // appBar: AppBar(
        //   backgroundColor: greenColor,
        //   actions: [
        //     // IconButton(
        //     //     onPressed: () {
        //     //       myController.data1.forEach((element) {
        //     //         print(element.name);
        //     //       });
        //     //     },
        //     //     icon: Icon(Icons.search)),
        //     IconButton(
        //         onPressed: (() => usersController.userLogout()),
        //         icon: const Icon(Icons.logout))
        //   ],
        //   title: const Text('AdminPanelView'),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            children: [
              TextField(
                controller: controller.searchTextController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.searchRecipeByKeywords(
                              controller.searchTextController.text);
                        },
                        icon: const Icon(Icons.search)),
                    border: const OutlineInputBorder(),
                    labelText: 'Cari resep . . .'),
              ),
              FutureBuilder<QuerySnapshot>(
                future: myController.streamDataOnDb(),
                builder: (context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                  if (asyncSnapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: asyncSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var _data = asyncSnapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      String docId = asyncSnapshot.data!.docs[index].id;
                      Recipes _dataResep = Recipes.fromJson(_data);
                      return InkWell(
                        onTap: (() => Get.toNamed(Routes.DETAILSCREEN,
                            arguments: [_dataResep, docId])),
                        child: Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(
                            elevation: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Image Section
                                Container(
                                  child: Image.network(
                                    _dataResep.imageUrl,
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
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                _dataResep.name,
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
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            "by ${_dataResep.recipeBy}",
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
                                              Text(_dataResep.cookTime)
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
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}
