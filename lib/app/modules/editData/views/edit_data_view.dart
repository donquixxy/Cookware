import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';

import 'package:get/get.dart';

import '../../../controllers/image_picker_controller.dart';
import '../controllers/edit_data_controller.dart';
import 'dart:math';

class EditDataView extends GetView<EditDataController> {
  @override
  Widget build(BuildContext context) {
    var imagePickerController = Get.put(ImagePickerController());
    Recipes resep = Get.arguments[0];
    var documentId = Get.arguments[1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 147, 114),
        elevation: 0,
        title: const Text("Edit Resep"),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object>>(
          future: controller.getDataFromDb(documentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            resep.imageUrl,
                            height: 150,
                            width: 300,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: controller.namaResepController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 20),
                                  label: const Text("Nama Resep")),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: controller.cookTimeController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 20),
                                  label: const Text("Durasi Masak")),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: controller.deskripsiController,
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 20),
                                  label: const Text("Deskripsi")),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  child: TextFormField(
                                    controller: controller.chipWordController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 25, horizontal: 20),
                                        label: const Text("Bahan Baku")),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.addDataToChip(
                                        controller.chipWordController.text);
                                  },
                                  child: const Text("Add"))
                            ],
                          ),
                          Obx(() => Expanded(
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2),
                                  itemCount: controller
                                      .resep.value.listIngredients.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Chip(
                                      onDeleted: () {
                                        print(index);
                                        controller.deleteDataChip(index);
                                        print(index);
                                      },
                                      backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      labelPadding: const EdgeInsets.all(4),
                                      label: Text(controller
                                          .resep.value.listIngredients[index]),
                                    );
                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.updateDataOnDb(
                documentId, controller.firebaseAuth.currentUser!.uid);
            // print(controller.resep.value.imageUrl);
          },
          child: const Icon(Icons.add)),
    );
  }
}
