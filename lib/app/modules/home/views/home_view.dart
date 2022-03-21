import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_DATA);
          },
          child: const Icon(Icons.add)),
    );
  }
}
