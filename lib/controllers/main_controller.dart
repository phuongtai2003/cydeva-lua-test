import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt currentNavIndex = 0.obs;

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
}
