// //<-------------main.dart code for demo ----------------------->
// import 'package:bloc_demo/demo/counter_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo/bloc.dart';
//
// void main(){
//   runApp(
//     BlocProvider(create: (_) => CounterBloc(),
//     child: const MyApp(),)
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CounterPage(),
//     );
//   }
// }

// //<-------------main.dart code for demo-2 ----------------------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_2/bloc/login_bloc.dart';
// import 'demo_2/screens/login_page.dart';
//
// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => LoginBloc(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }

// //<-------------main.dart code for demo-3 ----------------------->

// import 'dart:ui';
//
// import 'package:bloc_demo/demo_3/api_service.dart';
// import 'package:flutter/cupertino.dart' show runApp;
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_2/screens/login_page.dart';
// import 'demo_3/bloc/user_bloc.dart';
// import 'demo_3/screens/user_page.dart';
//
// void main(){
//   runApp(
//     BlocProvider(
//       create:(_) => UserBloc(ApiServices()),
//       child: const MyApp(),
//     ),
//   );
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: UserPage(),
//     );
//   }
// }

// //<-------------main.dart code for demo-4 ----------------------->

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_4/screens/login_page.dart';
// import 'demo_4/bloc/auth_bloc.dart';
// import 'demo_4/bloc/auth_state.dart';
// import 'demo_4/screens/home_page.dart';
//
//
// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => AuthBloc(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//
//           if (state is Authenticated) {
//             return HomePage();
//           }
//           return LoginPage();
//         },
//       ),
//     );
//   }
// }

// //<-------------main.dart code for demo-5 ----------------------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_5/bloc/user1_bloc.dart';
// import 'demo_5/repository/user_repository.dart';
// import 'demo_5/service/user_api_service.dart';
// import 'demo_5/ui/user_page.dart';
//
// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => UserBloc(
//             UserRepository(UserApiService()),
//           ),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const UserPage(),
//     );
//   }
// }

// //<-------------main.dart code for demo-6 ----------------------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'demo/counter_page.dart';
// import 'demo_6/counter_cubit.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Hydrated Storage
//   final storage = await HydratedStorage.build(
//     storageDirectory: await getApplicationDocumentsDirectory(),
//   );
//
//   HydratedBloc.storage = storage;
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CounterCubit(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: const CounterPage(),
//       ),
//     );
//   }
// }

// //<-------------main.dart code for demo-7 ----------------------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'demo_7/auth/auth_bloc.dart';
// import 'demo_7/auth/auth_state.dart';
// import 'demo_7/ui/home_page.dart';
// import 'demo_7/ui/login_page.dart';
//
//
// void main() {
//   runApp(
//     BlocProvider(
//       create: (_) => AuthBloc(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is Authenticated) {
//             return const HomePage();
//           } else {
//             return const LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_demo/demo_8/bloc/user3_event.dart';
import 'package:bloc_demo/demo_8/bloc/user3_state.dart';
import 'package:bloc_demo/demo_8/bloc/user3_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'demo_8/models/user_model.dart';
import 'demo_8/repository/user_local_repository.dart';
import 'demo_8/screens/user_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapter
  Hive.registerAdapter(UserModelAdapter());

  // Open Hive Box
  await Hive.openBox<UserModel>('usersBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          UserBloc(UserLocalRepository())..add(LoadUsersEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hive + BLoC Demo",
        home: UserScreen(),
      ),
    );
  }
}
