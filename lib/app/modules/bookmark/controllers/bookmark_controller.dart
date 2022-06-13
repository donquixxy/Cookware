import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  var firebaseFirestore = FirebaseFirestore.instance;
  var firebaseCurrentUser = FirebaseAuth.instance.currentUser;
  var isLiked = false.obs;
  var likedListUsers = <Recipes>[].obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserBookmarkData(
      {required String currentuid}) {
    var collectionRefs = firebaseFirestore
        .collection('UserLiked')
        .doc(currentuid)
        .collection('LikedItems')
        .snapshots();

    return collectionRefs;
  }

  @override
  void onInit() {
    streamUserBookmarkData(currentuid: firebaseCurrentUser!.uid);
    super.onInit();
  }

  void deleteFromBookmark(String docId, String currentUid) {
    Get.defaultDialog(
      title: 'Hapus Data',
      middleText: 'Apakah anda ingin menghapus resep dari bookmark ?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      onConfirm: () {
        Get.back();
        firebaseFirestore
            .collection('UserLiked')
            .doc(currentUid)
            .collection('LikedItems')
            .doc(docId)
            .delete();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
