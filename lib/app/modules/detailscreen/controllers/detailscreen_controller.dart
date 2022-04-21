import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class DetailscreenController extends GetxController {
  var firebaseFirestore = FirebaseFirestore.instance;
  var firebaseAuth = FirebaseAuth.instance;

  Recipes resep = Get.arguments[0];
  String documentId = Get.arguments[1];

  Future<void> addLikedIdToDB(
      {required String docId, required String currentUserId}) async {
    var collectionRefs = firebaseFirestore
        .collection('UserLiked')
        .doc(currentUserId)
        .collection('LikedItems')
        .doc(docId);

    Recipes _addedResep = Recipes(
        name: resep.name,
        description: resep.description,
        listIngredients: resep.listIngredients,
        cookTime: resep.cookTime,
        recipeBy: resep.recipeBy,
        imageUrl: resep.imageUrl,
        uidCreator: resep.uidCreator);

    collectionRefs.set(_addedResep.toJson());

    Get.defaultDialog(
      title: 'Sukses',
      middleText: 'Berhasil menambahkan ke favorit',
      textConfirm: 'OK',
      onConfirm: () {
        Get.back();
      },
    );
  }
}
