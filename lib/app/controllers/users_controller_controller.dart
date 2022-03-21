import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UsersControllerController extends GetxController {
  //TODO: Implement UsersControllerController

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Stream<User?> streamUserLogin() {
    var status = _firebaseAuth.authStateChanges();
    return status;
  }

  Future<void> userLogout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
