import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/login/views/login_view.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  var usersController = Get.find<UsersControllerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            child: const FlutterLogo(
              size: 80,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
            child: Text(
              'Register Account',
              style: StaticTheme.textStyle.copyWith(fontSize: 18),
            ),
          ),
          textFieldBuilder('Name', usersController.nameController, false),
          const SizedBox(
            height: 10,
          ),
          textFieldBuilder(
              'Your Email', usersController.emailController, false),
          const SizedBox(
            height: 10,
          ),
          textFieldBuilder(
              'Password', usersController.passwordController, true),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
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
    );
  }
}
