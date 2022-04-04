import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OverviewController extends GetxController {
  final _collectionRefs = FirebaseFirestore.instance.collection('Recipes');
  final auth = FirebaseAuth.instance;
  var currentIndex = 0.obs;
  Set<Recipes> listOfData = {};
  List<Recipes> data1 = [];

  Color backGroundColor = Colors.black;

  Future<QuerySnapshot> streamDataOnDb() async {
    final _snapshot = await _collectionRefs.get();

    for (var resultData in _snapshot.docs) {
      Recipes userData = Recipes.fromJson(resultData.data());
      if (!listOfData.contains(userData)) {
        listOfData.add(userData);
      }
    }

    return _snapshot;
  }

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  void changeCurrentIndexScreen(int index) {
    currentIndex.value = index;
    update();
  }

  void deleteData(String docId) {
    Get.defaultDialog(
        title: 'Hapus Data',
        middleText: 'Ingin Menghapus Data ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onConfirm: () {
          _collectionRefs.doc(docId).delete();
          Get.back();
        });
  }

  void showPopUp({required dynamic arguments, required String docId}) {
    Get.defaultDialog(
      title: 'Pilih Menu',
      middleText: 'Ingin Pindah ke Page mana ?',
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.EDIT_DATA, arguments: arguments);
            },
            child: const Text("Edit Data")),
        TextButton(
            onPressed: () {
              Get.back();
              _collectionRefs.doc(docId).delete();
            },
            child: const Text("Delete Data"))
      ],
    );
  }

  Future<void> fetchAllData() async {
    var data = await _collectionRefs.get();

    for (var element in data.docs) {
      listOfData.add(Recipes.fromJson(element.data()));
    }
    print(listOfData);
  }

  // Future <bool> onWilpop(){
  //   Get.defaultDialog(
  //     textCancel: 'NO',
  //     textConfirm: 'YA',
  //     onConfirm: (){

  //     }

  //   )
  // }
}
