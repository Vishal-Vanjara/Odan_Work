import 'package:flutter/material.dart';
import '../bloc/api_bloc.dart';
import '../bloc/api_event.dart';
import '../bloc/api_state.dart';


class HomePage extends StatefulWidget {
  final ApiBloc bloc;
  const HomePage({required this.bloc});


  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(FetchDataEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLoC API Demo')),
      body: StreamBuilder<ApiState>(
        stream: widget.bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;


          if (state is ApiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ApiSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index]['title']),
                );
              },
            );
          } else if (state is ApiError) {
            return Center(child: Text(state.message));
          }


          return Center(child: Text('Press refresh to load data'));
        },
      ),
    );
  }
}