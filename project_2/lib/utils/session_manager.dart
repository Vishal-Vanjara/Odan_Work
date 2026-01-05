import 'package:get/get.dart';

class SessionManager {
  static void clearSession() {
    // 🔥 Delete ALL controllers
    Get.deleteAll(force: true);

    // Optional: clear navigation stack
    Get.reset();
  }
}
