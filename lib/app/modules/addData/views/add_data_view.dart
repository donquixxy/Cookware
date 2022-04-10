import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/image_picker_controller.dart';

import 'package:get/get.dart';

import '../controllers/add_data_controller.dart';
import 'dart:math';

class AddDataView extends GetView<AddDataController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddDataController());
    var imagePickerController = Get.put(ImagePickerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 147, 114),
        elevation: 0,
        title: const Text("Add Resep"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 4, 147, 114),
        onPressed: () {
          controller.addDataToFirebase(imagePickerController.image!);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imagePickerController.adaIsi.isTrue
                      ? Image.file(
                          imagePickerController.image!,
                          height: 150,
                          width: 300,
                          fit: BoxFit.fill,
                        )
                      : GestureDetector(
                          onTap: () {
                            imagePickerController.pickImageFrom();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(15),
                            height: 150,
                            width: 300,
                            child: const Text(
                              "Insert Image",
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(border: Border.all()),
                          ),
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
                            onFieldSubmitted: controller.addDataToChip,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20),
                              label: const Text("Bahan Baku"),
                            ),
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
                  Obx((() => Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          itemCount: controller.chipWord.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Chip(
                              onDeleted: () {
                                controller.deleteDataChip(index);
                              },
                              backgroundColor: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              labelPadding: const EdgeInsets.all(4),
                              label: Text(controller.chipWord[index]),
                            );
                          },
                        ),
                      )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
