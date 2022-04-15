import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/login/views/login_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  var usersController = Get.find<UsersControllerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(
      //     opacity: 20,
      //   ),
      //   title: Text(
      //     "Sign up",
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontFamily: GoogleFonts.inter().fontFamily,
      //         fontWeight: FontWeight.w600),
      //   ),
      // ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Icon(
                Icons.restaurant_menu_sharp,
                size: 100,
                color: Color.fromARGB(255, 4, 147, 114),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 18, 26, 10),
              child: Text(
                'Create an \naccount',
                style: StaticTheme.textStyle.copyWith(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 32,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
              child: textFieldBuilder(
                  'Name', usersController.nameController, false, Icons.person),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
              child: textFieldBuilder('Your Email',
                  usersController.emailController, false, Icons.email),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
              child: textFieldBuilder('Password',
                  usersController.passwordController, true, Icons.password),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 10, 26, 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    primary: const Color.fromARGB(255, 4, 147, 114)),
                onPressed: () async {
                  // print('clicked');
                  await usersController.createEmailPassword();
                },
                child: Text(
                  "SIGN UP",
                  style: StaticTheme.textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
