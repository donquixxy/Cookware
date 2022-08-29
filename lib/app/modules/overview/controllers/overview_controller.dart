import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/controllers/resep_provider_controller.dart';
import 'package:get/get.dart';

class OverviewController extends GetxController {
  var myController = Get.put(ResepProviderController());
  final auth = FirebaseAuth.instance;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    myController.streamDataOnDb();
    super.onInit();
  }

  // void getResepFromDb() {
  //   myController.streamDataOnDb();
  // }

  void changeCurrentIndexScreen(int index) {
    currentIndex.value = index;
    update();
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
