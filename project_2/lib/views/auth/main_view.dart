
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/views/auth/find_people_view.dart';
import 'package:project_2/views/auth/friends_view.dart';
import 'package:project_2/views/auth/home_view.dart';
import 'package:project_2/views/auth/profile_view.dart';
import '../../controllers/friend_request_controller.dart';
import '../../controllers/friends_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/main_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/user_list_controller.dart';


class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {

    // // ✅ Register tab controllers ONCE
    // Get.put(HomeController(), permanent: true);
    // Get.put(FriendsController(), permanent: true);
    // Get.put(UserListController(), permanent: true);
    // Get.put(FriendRequestController(), permanent: true);
    // Get.put(ProfileController(), permanent: true);

    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            FriendsView(),
            FindPeopleView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF27B0A5),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_outlined),
              activeIcon: Icon(Icons.person_add_alt_1),
              label: 'Find Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}





//
// class MainView extends GetView<MainController> {
//   const MainView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//             () => IndexedStack(
//           index: controller.currentIndex.value,
//           children: const [
//
//             HomeView(),// ✅ already created
//             FriendsView(),// ✅ already created
//             FindPeopleView(),// ✅ already created
//             ProfileView(), // ✅ already created
//           ],
//         ),
//       ),
//       bottomNavigationBar: Obx(
//             () => BottomNavigationBar(
//           currentIndex: controller.currentIndex.value,
//           onTap: controller.changeTab,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Color(0xFF27B0A5),
//           unselectedItemColor: Colors.grey,
//           showUnselectedLabels: true,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat_bubble_outline),
//               activeIcon: Icon(Icons.chat_bubble),
//               label: 'Chats',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.group_outlined),
//               activeIcon: Icon(Icons.group),
//               label: 'Friends',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_add_alt_1_outlined),
//               activeIcon: Icon(Icons.person_add_alt_1),
//               label: 'Find Friends',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               activeIcon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
