// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/overview/views/overview_view.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginView extends GetView<LoginController> {
  final usersController = Get.put(UsersControllerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: usersController.streamUserLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data != null) {
                  return OverviewView();
                }
              }
              return Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        controller.loginWithGoogle();
                      },
                    ),
                    // SignInButton(Buttons.Email, onPressed: () {})
                  ],
                ),
              );
            }),
      ),
    );
  }
}
