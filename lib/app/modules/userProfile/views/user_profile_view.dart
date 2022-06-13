import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/static_theme.dart';
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
          backgroundColor: greenColor,
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
                return LayoutBuilder(builder: (context, Constraints) {
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
                                      color: greenColor,
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
                                      color: greenColor,
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
                            // onLongPress: () {
                            //   controller.showPopUp(
                            //       arguments: [resep, docId], docId: docId);
                            // },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 8, right: 10),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: resep.imageUrl,
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: double.infinity,
                                            errorWidget: (context, url, _) =>
                                                const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: PopupMenuButton(
                                            enableFeedback: true,
                                            onCanceled: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Colors.white70,
                                            ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      Routes.EDIT_DATA,
                                                      arguments: [resep, docId],
                                                    );
                                                  },
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.edit),
                                                      Text("Edit")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.deleteRecipe(
                                                        docId: docId);
                                                  },
                                                  child: Row(
                                                    children: const [
                                                      Icon(Icons.delete),
                                                      Text("Delete")
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Wrap(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 8, right: 8),
                                        child: Text(
                                          resep.name,
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ])
                                    //     Container(
                                    //       child: Row(
                                    //         children: [
                                    //           IconButton(
                                    //             onPressed: () {
                                    //               Get.toNamed(Routes.EDIT_DATA,
                                    //                   arguments: [
                                    //                     resep,
                                    //                     docId
                                    //                   ]);
                                    //             },
                                    //             icon: const Icon(
                                    //               Icons.edit,
                                    //               color: greenColor,
                                    //             ),
                                    //           ),
                                    //           IconButton(
                                    //             onPressed: () {},
                                    //             icon: Icon(
                                    //               Icons.delete,
                                    //               color: Colors.red.shade700,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                });
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
