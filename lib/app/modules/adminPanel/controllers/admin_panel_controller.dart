import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/controllers/resep_provider_controller.dart';
import 'package:flutter_application_1/app/data/models/recipe_models.dart';
import 'package:get/get.dart';

class AdminPanelController extends GetxController {
  var searchTextController = TextEditingController();
  final collectionRefs = FirebaseFirestore.instance.collection('Recipes');
  var isSubmitted = false.obs;
  var listSearched = List<Recipes>.empty(growable: true);
  var resepController = Get.find<ResepProviderController>();

  Future searchRecipeByKeywords(String keywords) async {
    isSubmitted.value = true;

    var data = await collectionRefs
        .where('namaResep', isGreaterThanOrEqualTo: keywords.capitalizeFirst!)
        .get();

    for (var resepList in data.docs) {
      var result = resepList.data();
      print(result);
      Recipes resep = Recipes.fromJson(result);
      listSearched.add(resep);
    }

    return data;
  }

  List<Recipes> searchRecipe(String keywords, List<Recipes> resultLists) {
    isSubmitted.toggle();

    // var query = keywords[0].capitalizeFirst;

    final result = resepController.data1
        .where((element) =>
            element.name.contains(keywords[0].capitalizeFirst.toString()))
        .toList();

    print(resepController.data1.length);
    print(result);

    for (var data in result) {
      // resultLists.clear();
      resultLists.add(data);
    }

    listSearched = resultLists;

    return result;
  }
}
