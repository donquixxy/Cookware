// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var usersController = Get.put(UsersControllerController());
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     "Sign in",
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontFamily: GoogleFonts.inter().fontFamily,
      //         fontWeight: FontWeight.w600),
      //   ),
      // ),
      body: StreamBuilder(
        stream: usersController.streamUserLogin(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              return FutureBuilder(
                future: usersController.isAdmin(snapshot.data!.uid),
                builder:
                    (BuildContext context, AsyncSnapshot<bool> snapshotData) {
                  if (snapshotData.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshotData.data!) {
                    usersController.imAdmin.value = true;
                    return HomeView();
                  } else if (snapshotData.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return HomeView();
                },
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }

          return ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Icon(
                  Icons.restaurant_menu_sharp,
                  size: 100,
                  color: greenColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 18, 22, 18),
                child: Text(
                  'Sign in \nto your account',
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldBuilder('Email',
                    usersController.emailController, false, Icons.email),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldBuilder('Password',
                    usersController.passwordController, true, Icons.password),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 18, 26, 18),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 50), primary: greenColor),
                    onPressed: () {
                      usersController.loginWithEmailPassword();
                      // print('clicked');
                    },
                    child: Obx(
                      () => controller.isClicked.isTrue
                          ? Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : Text(
                              "SIGN IN",
                              style: textStyle,
                            ),
                    )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Or',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(
                        Routes.SIGN_UP,
                        arguments: [
                          usersController.emailController.clear(),
                          usersController.passwordController.clear(),
                        ],
                      );
                    },
                    child: Text("Click here to Sign Up"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 12, 26, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50), primary: Colors.red.shade300),
                  onPressed: () {
                    controller.loginWithGoogle();
                  },
                  icon: Icon(MdiIcons.google),
                  label: Text(
                    "SIGN IN WITH GOOGLE",
                    style: textStyle,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

Widget textFieldBuilder(String labelText, TextEditingController controller,
    bool isHidden, IconData iconData) {
  // final usersController = Get.find<UsersControllerController>();

  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
    child: TextField(
      style: TextStyle(color: Colors.black87),
      obscureText: isHidden,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, color: greenColor),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
