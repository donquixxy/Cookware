import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/modules/overview/controllers/overview_controller.dart';
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

  void deleteRecipe({required String docId}) {
    Get.defaultDialog(
        middleText: 'Ingin Menghapus Resep ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onConfirm: () {
          firebaseFirestore.doc(docId).delete();
          Get.back();
        });
  }
}
