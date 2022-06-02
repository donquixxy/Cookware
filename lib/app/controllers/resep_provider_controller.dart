import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class ResepProviderController extends GetxController {
  final collectionRefs = FirebaseFirestore.instance.collection('Recipes');
  List<Recipes> data1 = [];

  Future<QuerySnapshot> streamDataOnDb() async {
    final _snapshot = await collectionRefs.get();

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

  void deleteResep(String docId) {
    Get.defaultDialog(
        title: 'Hapus Data',
        middleText: 'Ingin Menghapus Data ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onConfirm: () {
          collectionRefs.doc(docId).delete();
          Get.back();
        });
  }
}
