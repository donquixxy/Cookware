import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class EditDataController extends GetxController {
  //TODO: Implement EditDataController
  Recipes oldData = Get.arguments[0];
  var firstValue = [];
  List chipWord = [].obs;

  var resep = Recipes(
          name: '',
          description: '',
          listIngredients: [],
          cookTime: '',
          recipeBy: '',
          imageUrl: '',
          uidCreator: '')
      .obs;

  @override
  void onInit() {
    resep.update((val) {
      firstValue = oldData.listIngredients;
      val!.name = oldData.name;
      val.description = oldData.description;
      val.listIngredients = oldData.listIngredients;
      val.cookTime = oldData.cookTime;
      val.recipeBy = oldData.recipeBy;
      val.imageUrl = oldData.imageUrl;
      val.uidCreator = oldData.uidCreator;
      chipWord = oldData.listIngredients;
    });
    super.onInit();
  }

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  late var chipWordController = TextEditingController();
  late var namaResepController = TextEditingController(text: resep.value.name);
  late var deskripsiController =
      TextEditingController(text: resep.value.description);
  late var cookTimeController =
      TextEditingController(text: resep.value.cookTime);
  late var imageUrlController =
      TextEditingController(text: resep.value.imageUrl);

  void getNewData() {
    chipWord = oldData.listIngredients;
    resep.value.name = oldData.name;
    resep.value.description = oldData.description;
    resep.value.listIngredients = oldData.listIngredients;
    resep.value.cookTime = oldData.cookTime;
    resep.value.recipeBy = oldData.recipeBy;
    resep.value.imageUrl = oldData.imageUrl;
    resep.value.uidCreator = oldData.uidCreator;

    print(resep.value.name);
    print(resep.value.listIngredients);
    print(resep.value.cookTime);
  }

  void addDataToChip(String text) {
    chipWord.add(text);
    print(chipWord);
    chipWordController.clear();
    resep.refresh();
  }

  void deleteDataChip(int index) {
    Get.defaultDialog(
        title: 'Alert',
        middleText: 'Ingin Menghapus Bahan ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onCancel: () {},
        onConfirm: () {
          resep.value.listIngredients.removeAt(index);
          Get.back();
          resep.refresh();
        });
    print('rebuild');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromDb(
      String id) async {
    var collectionRefs =
        await firebaseFirestore.collection('Recipes').doc(id).get();
    return collectionRefs;
  }

  Future<void> updateDataOnDb(String id, String currentUid) async {
    try {
      // if (resep.value.uidCreator == currentUid) {
      Recipes newData = Recipes(
          name: namaResepController.text,
          description: deskripsiController.text,
          listIngredients: chipWord,
          cookTime: cookTimeController.text,
          recipeBy: firebaseAuth.currentUser!.displayName!,
          imageUrl: oldData.imageUrl,
          uidCreator: firebaseAuth.currentUser!.uid);

      firebaseFirestore.collection('Recipes').doc(id).update(newData.toJson());
      // Get.defaultDialog(
      //     title: 'Data Updated',
      //     middleText: 'Data berhasil terupdate',
      //     textConfirm: 'Ok',
      //     onConfirm: () {
      //       Get.back();
      //       Get.back();
      //     });

      Get.snackbar(
        'Data Updated',
        'Data Berhasil Terupdate',
        showProgressIndicator: true,
      );
      // } else {
      //   Get.defaultDialog(
      //       title: 'Error',
      //       middleText: 'Gagal Mengupdate, bukan data anda',
      //       textConfirm: 'Ok',
      //       onConfirm: () {
      //         Get.back();
      //       });
      // }
      resep.refresh();
    } on FirebaseException catch (error) {
      Get.defaultDialog(
          title: error.code,
          middleText: error.message!,
          textConfirm: 'Ok',
          onConfirm: () {
            Get.back();
          });
    }
  }

  @override
  void dispose() {
    chipWordController.dispose();
    print('dispoed');
    super.dispose();
  }
}
