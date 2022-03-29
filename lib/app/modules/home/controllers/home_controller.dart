import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  void changeCurrentIndexScreen(int index) {
    currentIndex.value = index;
    update();
  }
}
