import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/addData/views/add_data_view.dart';
import 'package:flutter_application_1/app/modules/bookmark/views/bookmark_view.dart';
import 'package:flutter_application_1/app/modules/overview/views/overview_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Obx(() => IndexedStack(
              index: controller.currentIndex.value,
              children: [
                OverviewView(),
                BookmarkView()
                // AddDataView(),
              ],
            )),
        bottomNavigationBar: SizedBox(
          height: 55,
          child: SalomonBottomBar(
            onTap: controller.changeCurrentIndexScreen,
            currentIndex: controller.currentIndex.value,
            items: [
              _bottomItemBar(Icons.home, 'Home', Colors.green),
              _bottomItemBar(Icons.favorite_border, 'Favorites', Colors.teal),
              _bottomItemBar(Icons.person, 'Account', Colors.pink)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_DATA);
            },
            child: const Icon(Icons.add)))));
  }
}

SalomonBottomBarItem _bottomItemBar(IconData icon, String title, Color color) =>
    SalomonBottomBarItem(
        icon: Icon(icon), title: Text(title), selectedColor: color);
