import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/data/models/user_models.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsersControllerController extends GetxController {
  @override
  void onClose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }

  @override
  void onInit() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    super.onInit();
  }

  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final firebaseFirestore = FirebaseFirestore.instance.collection('Users');
  var imAdmin = false.obs;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Stream<User?> streamUserLogin() {
    var status = firebaseAuth.authStateChanges();
    return status;
  }

  Future<void> userLogout() async {
    await firebaseAuth.signOut();
    imAdmin.value = false;
    googleSignIn.signOut();
  }

  Future<UserCredential?> createEmailPassword() async {
    try {
      if (nameController.text.isEmpty &&
          emailController.text.isEmpty &&
          passwordController.text.isEmpty) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Kolom Tidak boleh kosong !',
          textConfirm: 'Ok',
          onConfirm: () {
            Get.back();
          },
        );
      }
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      String uid = result.user!.uid;

      await result.user!.updateDisplayName(nameController.text);
      await result.user!.updatePhotoURL(
          'https://www.kindpng.com/picc/m/99-997900_headshot-silhouette-person-placeholder-hd-png-download.png');
      // await result.user!.updatePhotoURL(
      //     'https://www.pngitem.com/pimgs/m/99-998739_dale-engen-person-placeholder-hd-png-download.png');

      UserModels newUser = UserModels(
          email: emailController.text,
          displayName: nameController.text,
          uid: uid,
          isAdmin: false);

      await firebaseFirestore.doc(uid).set(newUser.toJson());

      Get.defaultDialog(
        title: 'Daftar Berhasil',
        middleText:
            'Akun telah berhasil didaftarkan !\n Akan dialihkan ke menu utama ',
        barrierDismissible: false,
        textConfirm: 'Ok',
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );

      return result;
    } on FirebaseAuthException catch (error) {
      Get.defaultDialog(
        barrierDismissible: false,
        title: error.code,
        middleText: error.message!,
        textConfirm: 'Ok',
        onConfirm: () {
          Get.back();
        },
      );
    }
    return null;
  }

  Future<UserCredential?> loginWithEmailPassword() async {
    try {
      // nameController.clear();
      // emailController.clear();
      // passwordController.clear();
      var userResult = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      return userResult;
    } on FirebaseException catch (error) {
      Get.defaultDialog(
        title: error.code,
        middleText: error.message!,
        textConfirm: 'Ok',
        onConfirm: () {
          Get.back();
        },
      );
    }
    return null;
  }

  Future<bool> isAdmin(String uid) async {
    try {
      var data = await firebaseFirestore.doc(uid).get();
      // var results = data.data();
      // print(results);
      // UserModels userLogin = UserModels.fromJson(results!);
      if (data.data()?['isAdmin'] == true) {
        // print('u are admin');
        imAdmin.value = true;
        return true;
      } else {
        imAdmin.value = false;
        // print('ur not admin');
        return false;
      }

      // if (userLogin.isAdmin) {
      //   imAdmin.value = false;
      //   return true;
      // } else {
      //   imAdmin.value = false;
      //   return false;
      // }

      // print(result.length);
      // print(result);
    } on Exception {
      Get.defaultDialog(
          textConfirm: 'Terjadi Kesalahan',
          onConfirm: () {
            Get.back();
          });

      return false;
    }
  }
}
