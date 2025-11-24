import 'package:get/get.dart';
import 'package:getx_demo/models/todo.dart';

class TodoController extends GetxController{
  var todos = <Todo>[].obs;

  void addTodo(String title){
    todos.add(Todo(title: title));
  }

  void toggleTodoStatus(int index){
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void deleteTodo(int index){
    todos.removeAt(index);
  }

}