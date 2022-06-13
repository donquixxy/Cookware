import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final collectionRefs = FirebaseFirestore.instance.collection('Recipes');
  // var testController = Get.find<AdminPanelController>();
  var searchTextController = TextEditingController(text: '');
  var isSubmitted = false.obs;
  var listSearched = [].obs;
  // var testData = {}.obs;
  List<Recipes> lister = <Recipes>[].obs;
  var listOfMappedResep = <String, dynamic>{}.obs;
  var valuesResep = <String, dynamic>{}.obs;

  Future<QuerySnapshot> searchRecipeByKeywords(
      String keywords, List<Recipes> temp) async {
    isSubmitted.value = true;

    // temp.clear();

    var data = await collectionRefs
        .where('namaResep', isGreaterThanOrEqualTo: keywords.capitalizeFirst!)
        .get();

    for (var resepList in data.docs) {
      var result = resepList.data();
      print(result);
      Recipes resep = Recipes.fromJson(result);
      temp.add(resep);
      // testData.addAll(result);

      // print(testData);
    }

    return data;
  }

  void searchByName(String query, List<Recipes> temporary) async {
    var data = await collectionRefs
        .where('namaResep', isGreaterThanOrEqualTo: query.capitalizeFirst)
        .where('namaResep', isLessThan: query + 'z')
        .get();

    for (var result in data.docs) {
      var asdfa = result.data();

      Recipes filterResep = Recipes.fromJson(result.data());

      bool isValid =
          asdfa['namaResep'][0] == query[0].capitalizeFirst.toString();

      // String docId = result.id;
      temporary.addIf(isValid, filterResep);
    }

    lister = temporary;

    for (var element in lister) {
      print(element.name);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchText(String keywords) {
    var data = collectionRefs
        .where('namaResep', isGreaterThanOrEqualTo: keywords.capitalizeFirst!)
        .snapshots();

    return data;
  }

  void showPopUp({required dynamic arguments, required String docId}) {
    Get.defaultDialog(
      middleText: 'Pilih aksi yang akan dilakukan',
      middleTextStyle: const TextStyle(
        fontSize: 18,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.EDIT_DATA, arguments: arguments);
            },
            child: const Text("Edit Data")),
        TextButton(
            onPressed: () {
              Get.back();
              collectionRefs.doc(docId).delete();
              Get.defaultDialog(
                title: 'Sukses',
                middleText: 'Data Berhasil Dihapus',
                textConfirm: 'Ok',
                onConfirm: () {
                  Get.back();
                  Get.back();
                },
              );
            },
            child: const Text("Delete Data"))
      ],
    );
  }
}
