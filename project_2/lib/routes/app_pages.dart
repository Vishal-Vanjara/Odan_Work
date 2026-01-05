import 'package:get/get.dart';
import 'package:project_2/controllers/friend_request_controller.dart';
import 'package:project_2/controllers/home_controller.dart';
import 'package:project_2/routes/app_routes.dart';
import 'package:project_2/views/auth/home_view.dart';

import '../controllers/chat_controller.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/friends_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/user_list_controller.dart';
import '../views/auth/chat_view.dart';
import '../views/auth/find_people_view.dart';
import '../views/auth/forgot_password_view.dart';
import '../views/auth/friend_request_view.dart';
import '../views/auth/friends_view.dart';
import '../views/auth/main_view.dart';
import '../views/auth/notification_view.dart';
import '../views/auth/profile_view.dart';
import '../views/auth/splash_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
    ),

    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.put(ForgotPasswordController());
      }),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),


    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: BindingsBuilder(() {
        // Get.put(MainController(), permanent: true);

        // 🔥 TAB CONTROLLERS (CREATE ONCE)
        Get.put(HomeController());
        Get.put(FriendsController(), );
        Get.put(UserListController(), );
        Get.put(ProfileController(),);
      }),
    ),



    GetPage(
      name: AppRoutes.friendRequest,
      page: () => const FriendRequestView(),
      binding: BindingsBuilder(() {
        Get.put(FriendRequestController());
      }),
    ),


    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
    ),

    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationView(),
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),


    // GetPage(
    //   name: AppRoutes.userList,
    //   page: () => const FindPeopleView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(UserListController());
    //   }),
    // ),

    // GetPage(
    //   name: AppRoutes.friends,
    //   page: () => const FriendsView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(FriendsController());
    //   }),
    // ),

    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(HomeController());
    //   }),
    // ),




    // 🔽 Keep your future routes commented as-is
    // GetPage(name: AppRoutes.home, page: () => const HomeView()),
    // GetPage(name: AppRoutes.main, page: () => const MainView()),
  ];
}
