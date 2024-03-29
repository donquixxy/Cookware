import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/models/user_models.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  var isClicked = false.obs;

  Future<void> loginWithGoogle() async {
    final _collectionRefs = _firebaseFirestore.collection('Users');
    final _googleSignIn = GoogleSignIn();
    final _account = await _googleSignIn.signIn();
    try {
      isClicked.isFalse;
      if (_account != null) {
        final _googleAuth = await _account.authentication;

        final _authCredential = GoogleAuthProvider.credential(
            accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);

        try {
          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(_authCredential);

          var _exist = await _firebaseFirestore
              .collection('Users')
              .doc(userCredential.user!.uid)
              .get();

          //Check if UID is Exist \\
          if (!_exist.exists) {
            try {
              UserModels _newUser = UserModels(
                  email: userCredential.user!.email!,
                  displayName: userCredential.user!.displayName!,
                  uid: userCredential.user!.uid,
                  isAdmin: false
                  // likedItems: []
                  );
              _collectionRefs
                  .doc(userCredential.user!.uid)
                  .set(_newUser.toJson());
            } on FirebaseAuthException catch (error) {
              Get.defaultDialog(
                  middleText: "User Already Registered",
                  title: error.code,
                  textConfirm: 'OK',
                  onConfirm: () {
                    Get.back();
                  });
            }
          }
        } on FirebaseAuthException catch (error) {
          Get.defaultDialog(
              middleText: error.message!,
              title: error.code,
              textConfirm: 'OK',
              onConfirm: () {
                Get.back();
              });
        }
        isClicked.isTrue;
      }
    } catch (error) {
      Get.defaultDialog(
        title: 'Failed To Sign In',
        middleText: 'Ingin Mencoba Sign In kembali ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          loginWithGoogle();
        },
      );
    } finally {
      isClicked.isFalse;
    }
  }
}
