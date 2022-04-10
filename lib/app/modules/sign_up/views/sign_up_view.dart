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
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color.fromARGB(255, 4, 147, 114),
      // ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Color(0x665ac18e),
        //       Color(0x995ac18e),
        //       Color(0xcc5ac18e),
        //       Color(0xFF5ac18e)
        //     ],
        //   ),
        // ),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
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
              padding: const EdgeInsets.fromLTRB(26, 10, 26, 10),
              child: Center(
                child: Text(
                  'Register Account',
                  style: StaticTheme.textStyle.copyWith(
                    fontSize: 22,
                    color: Colors.black87,
                  ),
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
