import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/users_controller_controller.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UsersControllerController>();
    var controller = Get.put(UserProfileController());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 4, 147, 114),
          onPressed: () {
            Get.toNamed(Routes.ADD_DATA);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: StreamBuilder(
          stream: controller.userDataList(
              uid: userController.firebaseAuth.currentUser!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            maxRadius: 60,
                            backgroundImage: NetworkImage(
                              userController
                                      .firebaseAuth.currentUser!.photoURL ??
                                  '',
                            ),
                          ),
                          Text(
                            userController
                                    .firebaseAuth.currentUser!.displayName ??
                                '',
                            style: const TextStyle(fontSize: 18),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       child: Column(
                          //         children: const [
                          //           Text("100"),
                          //           Text("Total Posts")
                          //         ],
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 30,
                          //     ),
                          //     Container(
                          //       child: Column(
                          //         children: const [
                          //           Text("200"),
                          //           Text("Total Favorites")
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 4, 147, 114),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Your Post",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                  child: Divider(
                                    height: 20,
                                    thickness: 3,
                                    color: Color.fromARGB(255, 4, 147, 114),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 6,
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _snapshotData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        String docId = snapshot.data!.docs[index].id;
                        Recipes resep = Recipes.fromJson(_snapshotData);
                        // print(_snapshotData);

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAILSCREEN,
                                arguments: [resep, docId]);
                          },
                          onLongPress: () {
                            controller.showPopUp(
                                arguments: [resep, docId], docId: docId);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 8, right: 10),
                            child: Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  resep.imageUrl,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 8),
                                  child: Text(
                                    resep.name,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: Text("No Data Yet"),
            );
          },
        ),
      ),
    );
  }
}
