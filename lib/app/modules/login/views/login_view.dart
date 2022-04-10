// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final usersController = Get.put(UsersControllerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: usersController.streamUserLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              return HomeView();
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
                margin: EdgeInsets.only(top: 80),
                child: const Icon(
                  Icons.restaurant_menu_sharp,
                  size: 100,
                  color: Color.fromARGB(255, 4, 147, 114),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 18, 22, 18),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
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
                      minimumSize: Size(50, 50),
                      primary: const Color.fromARGB(255, 4, 147, 114)),
                  onPressed: () {
                    usersController.loginWithEmailPassword();
                    // print('clicked');
                  },
                  child: Text(
                    "SIGN IN",
                    style: StaticTheme.textStyle,
                  ),
                ),
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
                    style: StaticTheme.textStyle,
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
        prefixIcon: Icon(iconData, color: Color.fromARGB(255, 4, 147, 114)),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    ),
  );
}
