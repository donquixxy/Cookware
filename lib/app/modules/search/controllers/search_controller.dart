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

    // List testList = [];
    // Map<String, dynamic> abcd = {};
    // Map<String, dynamic> values = {};

    // print(data.docs);

    for (var result in data.docs) {
      // print(result.data());
      // temporary.clear();
      var asdfa = result.data();

      Recipes filterResep = Recipes.fromJson(result.data());

      // var test = asdfa.startsWith(query[0].capitalizeFirst.toString());
      var isValid =
          asdfa['namaResep'][0] == query[0].capitalizeFirst.toString();

      var okie = result.id;

      // print('okie ${okie}');

      // print('text ${asdfa} hasilnya ${test}');

      // testList.addIf(test, filterResep);

      // listSearched.addIf(test, filterResep);

      temporary.addIf(isValid, filterResep);

      // for (var index = 0; index < temporary.length; index++) {
      //   if (!temporary[index].name.contains(filterResep.name)) {
      //     temporary.removeAt(index);
      //   }
      // }

      // print(lister);

      // for (var items in asdfa.entries) {
      //   abcd.putIfAbsent('docId', () {
      //     var isOk =
      //         asdfa['namaResep'][0] == query[0].capitalizeFirst.toString();

      //     if (isOk){}

      //   });
      // }

      // values.addIf(test, "docId", okie);
      // abcd.addIf(test, 'dataResep', result.data());

      // // Map<String, dynamic> thirdMap = {...values, ...abcd};

      // // print(thirdMap);

      // resultQuery = {...values, ...abcd};

      // print(resultQuery.length);

      // print(resultQuery);

      // print(listOfMappedResep);

      // print(values);

      // abcd.map((key, value){
      //   abcd.putIfAbsent(key, () => null)
      // })

      // abcd.addIf(
      //   test,
      //   'docId',
      // );

      // print(abcd);

      // print(test);

      // var test =
      //     result.data().containsValue(query.capitalizeFirst![0].toString());

      // print(test);
    }

    lister = temporary;

    for (var element in lister) {
      print(element.name);
    }
    // valuesResep.value = resultQuery;

    // print(valuesResep);
    // testList.forEach((element) {
    //   print(element);
    // });

    // lister.value = testList;

    // listSearched.forEach((element) {
    //   print(element.name);
    // });
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
