import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/bookmark/views/bookmark_view.dart';
import 'package:flutter_application_1/app/modules/overview/views/overview_view.dart';
import 'package:flutter_application_1/app/modules/userProfile/views/user_profile_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(40),
        //         bottomRight: Radius.circular(40)),
        //   ),
        //   toolbarHeight: 180,
        //   // flexibleSpace: Container(
        //   //   decoration: const BoxDecoration(
        //   //     borderRadius: BorderRadius.only(
        //   //       bottomLeft: Radius.circular(40),
        //   //       bottomRight: Radius.circular(40),
        //   //     ),
        //   //   ),
        //   // ),
        //   // backgroundColor: Colors.transparent,
        //   title: Container(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const [
        //         Icon(
        //           Icons.restaurant_menu,
        //           color: Colors.white,
        //         ),
        //         Text(
        //           'Cookware',
        //           style: TextStyle(
        //               color: Colors.white, fontWeight: FontWeight.bold),
        //         ),
        //       ],
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        body: Obx(() => IndexedStack(
              index: controller.currentIndex.value,
              children: [
                OverviewView(),
                BookmarkView(),
                UserProfileView()
                // AddDataView(),
              ],
            )),
        bottomNavigationBar: SizedBox(
          height: 55,
          child: SalomonBottomBar(
            curve: Curves.bounceOut,
            onTap: controller.changeCurrentIndexScreen,
            currentIndex: controller.currentIndex.value,
            items: [
              _bottomItemBar(
                  Icons.home, 'Home', const Color.fromARGB(255, 8, 167, 16)),
              _bottomItemBar(Icons.favorite, 'Favorites',
                  const Color.fromARGB(255, 216, 6, 97)),
              _bottomItemBar(Icons.person, 'Account', Colors.teal.shade800)
              // _bottomItemBar(Icons.person, 'Account', Colors.pink)
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
        icon: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        selectedColor: color);
