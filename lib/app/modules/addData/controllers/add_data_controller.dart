import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddDataController extends GetxController with StateMixin {
  List chipWord = [].obs;

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  var chipWordController = TextEditingController();
  var namaResepController = TextEditingController();
  var deskripsiController = TextEditingController();
  var cookTimeController = TextEditingController();
  var imageUrlController = TextEditingController();
  var isLoading = false.obs;

  void addDataToChip(String text) {
    chipWord.add(text);
    // print(chipWord);
    chipWordController.clear();
  }

  void deleteDataChip(int index) {
    chipWord.removeAt(index);
    // print(chipWord);
  }

  @override
  void dispose() {
    chipWordController.dispose();
    // print('dispoed');
    super.dispose();
  }

  Future<void> addDataToFirebase(File file) async {
    var storageRefs = firebaseStorage.ref().child('Images/Recipes');
    var collectionRefs = firebaseFirestore.collection('Recipes');
    if (chipWord.isNotEmpty &&
        namaResepController.text.isNotEmpty &&
        deskripsiController.text.isNotEmpty &&
        cookTimeController.text.isNotEmpty) {
      try {
        isLoading.toggle();
        final filename = basename(file.path);
        final imagePath = storageRefs.child('testis').child(filename);
        final _uploadedFile = await imagePath.putFile(file);
        final _imageUrl = await _uploadedFile.ref.getDownloadURL();

        String documentId = collectionRefs.doc().id;

        Recipes _addedResep = Recipes(
            id: documentId,
            name: namaResepController.text,
            description: deskripsiController.text.trim(),
            listIngredients: chipWord,
            cookTime: cookTimeController.text,
            recipeBy: firebaseAuth.currentUser!.displayName!,
            imageUrl: _imageUrl,
            uidCreator: firebaseAuth.currentUser!.uid);

        await collectionRefs.doc(documentId).set(_addedResep.toJson());

        isLoading.toggle();
        Get.defaultDialog(
          title: 'Data Tersimpan !',
          middleText: 'Berhasil Menambahkan Resep',
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
            Get.back();
          },
        );
      } on FirebaseException catch (error) {
        Get.defaultDialog(
          title: error.message!,
          middleText: error.code,
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Gagal Menyimpan Data',
        middleText: 'Field Tidak boleh kosong !',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
