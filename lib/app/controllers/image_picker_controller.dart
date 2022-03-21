import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  //TODO: Implement ImagePickerController

  File? image;
  var adaIsi = false.obs;

  Future<void> getImageFromCamera(File? file) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? imagePicked =
          await _picker.pickImage(source: ImageSource.camera);
      image = File(imagePicked!.path);
      adaIsi.toggle();
      print(adaIsi);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Input image gagal, apakah anda ingin menginput ulang ?",
          actions: [
            TextButton(
                onPressed: () => pickImageFrom(), child: const Text("OK")),
            TextButton(onPressed: () => Get.back(), child: const Text("Cancel"))
          ]);
    }
  }

  Future<void> getImageFromGallery(File? file) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? imagePicked =
          await _picker.pickImage(source: ImageSource.gallery);
      image = File(imagePicked!.path);
      adaIsi.toggle();
      print(adaIsi);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Input image gagal, apakah anda ingin menginput ulang ?",
          actions: [
            TextButton(
                onPressed: () => pickImageFrom(), child: const Text("OK")),
            TextButton(onPressed: () => Get.back(), child: const Text("Cancel"))
          ]);
    }
  }

  void pickImageFrom() {
    Get.bottomSheet(SafeArea(
        child: Container(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: const Text("Pick from camera"),
            onTap: () {
              getImageFromCamera(image);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: const Text("Pick from Gallery"),
            onTap: () {
              getImageFromGallery(image);
              Get.back();
            },
          )
        ],
      ),
    )));
  }
}
