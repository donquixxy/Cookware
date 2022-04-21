import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/overview/controllers/overview_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController with StateMixin {
  var firebaseAuth = FirebaseAuth.instance;
  var firebaseFirestore = FirebaseFirestore.instance.collection('Recipes');
  // Set<Recipes> userData = {};
  // Set<Recipes> filteredSet = {};
  var userController = Get.find<OverviewController>();

  Stream<QuerySnapshot<Map<String, dynamic>>> userDataList(
      {required String uid}) {
    var filter =
        firebaseFirestore.where('uidCreator', isEqualTo: uid).snapshots();

    return filter;
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
              firebaseFirestore.doc(docId).delete();
              Get.defaultDialog(
                title: 'Sukses',
                middleText: 'Data Berhasil Dihapus',
                textConfirm: 'Ok',
                onConfirm: () {
                  Get.back();
                  Get.back();
                },
              );
            },
            child: const Text("Delete Data"))
      ],
    );
  }
}
