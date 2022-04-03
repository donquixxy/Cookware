import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';

import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UsersControllerController>();
    var controller = Get.put(UserProfileController());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            IconButton(
                onPressed: () {
                  controller.fetchUserCollection(
                      uid: controller.firebaseAuth.currentUser!.uid);
                },
                icon: Icon(Icons.add)),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 60,
                    backgroundImage: NetworkImage(
                        userController.firebaseAuth.currentUser!.photoURL!),
                  ),
                  Text(userController.firebaseAuth.currentUser!.displayName!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: const [Text("100"), Text("Total Posts")],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Column(
                          children: const [
                            Text("200"),
                            Text("Total Favorites")
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 140,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card();
              },
            ),
          ],
        ),
      ),
    );
  }
}
