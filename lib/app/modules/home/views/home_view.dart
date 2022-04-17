import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/bookmark/views/bookmark_view.dart';
import 'package:flutter_application_1/app/modules/overview/views/overview_view.dart';
import 'package:flutter_application_1/app/modules/userProfile/views/user_profile_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  final userController = Get.find<UsersControllerController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 147, 114),
              elevation: 0,
              title: Container(
                child: Row(
                  children: const [
                    Spacer(),
                    Icon(Icons.restaurant_menu),
                    Text("Cookware"),
                    Spacer(),
                  ],
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      userController.userLogout();
                    },
                    icon: const Icon(Icons.logout))
              ],
              centerTitle: true,
            ),
            body: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  OverviewView(),
                  BookmarkView(),
                  UserProfileView()
                  // AddDataView(),
                ],
              ),
            ),
            bottomNavigationBar: SalomonBottomBar(
              curve: Curves.bounceOut,
              onTap: controller.changeCurrentIndexScreen,
              currentIndex: controller.currentIndex.value,
              items: [
                _bottomItemBar(
                    Icons.home, 'Home', const Color.fromARGB(255, 4, 147, 114)),
                _bottomItemBar(Icons.favorite, 'Favorites', Colors.pink),
                _bottomItemBar(Icons.person, 'Account', Colors.teal)
                // _bottomItemBar(Icons.person, 'Account', Colors.pink)
              ],
            ),
          )),
    );
  }
}

SalomonBottomBarItem _bottomItemBar(IconData icon, String title, Color color) =>
    SalomonBottomBarItem(
        icon: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        selectedColor: color);
