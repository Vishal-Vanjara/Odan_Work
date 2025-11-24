import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("GetX TODO App"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add',), child: Icon(Icons.add),
      ),
      body: Obx((){
        if (controller.todos.isEmpty){
          return Center(child: Text("No tasks yet"),);
        }
      }),
    );
  }
}
