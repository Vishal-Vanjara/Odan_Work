
// <----------this code for increment and decrement --------->
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'counter/counter_bloc.dart' show CounterBloc;
// import 'counter/counter_event.dart';
// import 'counter/counter_state.dart';
//
//
// void main() {
//   runApp(const MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter BLoC Demo',
//       home: BlocProvider(
//         create: (_) => CounterBloc(),
//         child: const CounterPage(),
//       ),
//     );
//   }
// }
//
//
// class CounterPage extends StatelessWidget {
//   const CounterPage({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('BLoC Counter')),
//       body: Center(
//         child: BlocBuilder<CounterBloc, CounterState>(
//           builder: (context, state) {
//             return Text(
//               'Count: ${state.count}',
//               style: const TextStyle(fontSize: 30),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(width: 12),
//           FloatingActionButton(
//             onPressed: () => context.read<CounterBloc>().add(DecrementEvent()),
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Toggle_on_off_app/toggle/toggle_bloc.dart';
import 'Toggle_on_off_app/toggle/toggle_event.dart';
import 'Toggle_on_off_app/toggle/toggle_state.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ToggleBloc(),
        child: const TogglePage(),
      ),
    );
  }
}


class TogglePage extends StatelessWidget {
  const TogglePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toggle BLoC App')),
      body: Center(
        child: BlocBuilder<ToggleBloc, ToggleState>(
          builder: (context, state) {
            return Text(
              state.isOn ? 'ON' : 'OFF',
              style: const TextStyle(fontSize: 40),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ToggleBloc>().add(TogglePressed()),
        child: const Icon(Icons.power_settings_new),
      ),
    );
  }
}