import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsersControllerController extends GetxController {
  //TODO: Implement UsersControllerController

  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Stream<User?> streamUserLogin() {
    var status = firebaseAuth.authStateChanges();
    return status;
  }

  Future<void> userLogout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
