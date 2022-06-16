import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/modules/adminPanel/views/admin_panel_view.dart';
import 'package:flutter_application_1/app/modules/bookmark/views/bookmark_view.dart';
import 'package:flutter_application_1/app/modules/overview/views/overview_view.dart';
import 'package:flutter_application_1/app/modules/search/views/search_view.dart';
import 'package:flutter_application_1/app/modules/userProfile/views/user_profile_view.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var userController = Get.find<UsersControllerController>();
    return Obx(
      (() => Scaffold(
            appBar: AppBar(
              backgroundColor: greenColor,
              elevation: 0,
              title: Row(
                children: const [
                  Spacer(),
                  Icon(Icons.restaurant_menu),
                  Text("Cookware"),
                  Spacer(),
                ],
              ),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       userController.isAdmin(
                //           userController.firebaseAuth.currentUser!.uid);
                //     },
                //     icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      userController.userLogout();
                    },
                    icon: const Icon(Icons.logout))
              ],
              centerTitle: true,
            ),
            body: Obx(
              () => userController.imAdmin.value == true
                  ? IndexedStack(
                      index: controller.currentIndex.value,
                      children: [AdminPanelView(), SearchView()],
                    )
                  : IndexedStack(
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
              items: userController.imAdmin.value == true
                  ? [
                      _bottomItemBar(Icons.home, 'Home', greenColor),
                      _bottomItemBar(Icons.search, 'Search', Colors.blue),
                      // _bottomItemBar(Icons.person, 'Account', Colors.teal)
                      // _bottomItemBar(Icons.person, 'Account', Colors.pink)
                    ]
                  : [
                      _bottomItemBar(Icons.home, 'Home', greenColor),
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
