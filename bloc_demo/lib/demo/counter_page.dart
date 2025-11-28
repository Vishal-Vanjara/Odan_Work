import 'package:bloc_demo/demo/bloc.dart';
import 'package:bloc_demo/demo/event.dart';
import 'package:bloc_demo/demo/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter App (BLoC)")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (_, state) {
            return Text(
              "Count : ${state.count}",
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Inc",
            onPressed: () {
              context.read<CounterBloc>().add(IncrementEvent());
            },
            child: const Icon(Icons.add),
          ),

          SizedBox(width: 10),

          FloatingActionButton(
            heroTag: "Dec",
            onPressed: () {
              context.read<CounterBloc>().add(DecrementEvent());
            },
            child: const Icon(Icons.remove),
          ),

          SizedBox(width: 10),

          FloatingActionButton(
            heroTag:"Rest",
            onPressed: () {
              context.read<CounterBloc>().add(ResetEvent());
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
