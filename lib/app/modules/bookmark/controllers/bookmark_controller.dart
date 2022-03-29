import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  var firebaseFirestore = FirebaseFirestore.instance;
  var firebaseCurrentUser = FirebaseAuth.instance.currentUser;
  var isLiked = false.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserBookmarkData(
      {required String currentuid}) {
    var collectionRefs = firebaseFirestore
        .collection('UserLiked')
        .doc(currentuid)
        .collection('LikedItems')
        .snapshots();

    return collectionRefs;
  }

  Future<bool> isInBookMarkCollection(
      {required String docId, required String currentuId}) async {
    var data = await firebaseFirestore
        .collection('UserLiked')
        .doc(currentuId)
        .collection('LikedItems')
        .doc(docId)
        .get();

    if (data.exists) {
      isLiked.value = true;
      print(isLiked.value);
      return isLiked.value;
    }
    print(isLiked.value);
    return !isLiked.value;
  }
}
