import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';

import 'package:get/get.dart';

import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  var usersController = Get.find<UsersControllerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                usersController.userLogout();
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('AdminPanelView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AdminPanelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
