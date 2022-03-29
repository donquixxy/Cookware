import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/modules/overview/views/card_widget.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  final controller = Get.put(OverviewController());
  final usersController = Get.put(UsersControllerController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamDataOnDb(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var _data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                Recipes dataResep = Recipes.fromJson(_data);
                final documentId = snapshot.data!.docs[index].id;
                return GestureDetector(
                    onLongPress: () {
                      controller.showPopUp(
                          arguments: [dataResep, documentId],
                          docId: documentId);
                      // controller.deleteData(documentId);
                      print(documentId);
                    },
                    onTap: () {
                      // Get.toNamed(Routes.EDIT_DATA,
                      //     arguments: [dataResep, documentId]);
                      Get.toNamed(Routes.DETAILSCREEN,
                          arguments: [dataResep, documentId]);
                    },
                    child: CardWidget(
                      docId: documentId,
                      resep: dataResep,
                    ));
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
