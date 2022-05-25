import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class OverviewController extends GetxController {
  final _collectionRefs = FirebaseFirestore.instance.collection('Recipes');
  final auth = FirebaseAuth.instance;
  var currentIndex = 0.obs;
  List<Recipes> data1 = [];

  Future<QuerySnapshot> streamDataOnDb() async {
    final _snapshot = await _collectionRefs.get();

    List<Recipes> _recipesList = [];

    // _snapshot.docs.forEach(
    //   (element) {
    //     Recipes dataResep = Recipes.fromJson(element.data());

    //     _recipesList.add(dataResep);
    //   },
    // );

    _snapshot.docs.map((newData) {
      Recipes dataResep = Recipes.fromJson(newData.data());
      _recipesList.add(dataResep);
    }).toList();

    data1 = _recipesList;
    return _snapshot;
  }

  @override
  void onInit() {
    streamDataOnDb();
    super.onInit();
  }

  void changeCurrentIndexScreen(int index) {
    currentIndex.value = index;
    update();
  }

  void deleteData(String docId) {
    Get.defaultDialog(
        title: 'Hapus Data',
        middleText: 'Ingin Menghapus Data ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onConfirm: () {
          _collectionRefs.doc(docId).delete();
          Get.back();
        });
  }

  // Future<void> fetchAllData() async {
  //   var data = await _collectionRefs.get();

  //   for (var element in data.docs) {
  //     listOfData.add(Recipes.fromJson(element.data()));
  //   }
  //   print(listOfData);
  // }

  // Future <bool> onWilpop(){
  //   Get.defaultDialog(
  //     textCancel: 'NO',
  //     textConfirm: 'YA',
  //     onConfirm: (){

  //     }

  //   )
  // }
}
