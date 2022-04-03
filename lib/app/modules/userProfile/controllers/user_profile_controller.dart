import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/modules/overview/controllers/overview_controller.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var firebaseFirestore = FirebaseFirestore.instance.collection('Recipes');
  List<Recipes> userData = [];
  var userController = Get.find<OverviewController>();

  @override
  void onInit() {
    currentUserListData(currentUid: userController.auth.currentUser!.uid);
    super.onInit();
  }

  void currentUserListData({required String currentUid}) {
    var result = userController.listOfData
        .where((element) => element.uidCreator == currentUid)
        .map((e) => userData.add(e))
        .toList();
  }

  Future<void> fetchUserCollection({required String uid}) async {
    var data =
        await firebaseFirestore.where('uidCreator', isEqualTo: uid).get();
    for (var result in data.docs) {
      Recipes data = Recipes.fromJson(result.data());
      print(data.toJson());
    }
  }
}
