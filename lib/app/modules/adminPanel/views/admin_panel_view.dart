import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/resep_provider_controller.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  @override
  Widget build(BuildContext context) {
    // var usersController = Get.find<UsersControllerController>();
    var myController = Get.put(ResepProviderController());
    // var controller = Get.put(AdminPanelController());

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
      body: RefreshIndicator(
        onRefresh: myController.streamDataOnDb,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: myController.data1.length,
              itemBuilder: (BuildContext context, int index) {
                Recipes _dataResep = myController.data1[index];
                return InkWell(
                  onTap: (() => Get.toNamed(Routes.DETAILSCREEN,
                      arguments: [_dataResep, _dataResep.id])),
                  child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Image Section

                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: _dataResep.imageUrl,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Image.asset('assets/placeholder.jpg'),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          //End of Image Section

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "by ${_dataResep.recipeBy}",
                                      softWrap: false,
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
            ),
          ),
        ),
      ),
    );
  }
}
