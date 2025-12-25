import 'package:get/get.dart';

class MainController extends GetxController {
  /// current bottom nav index
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
