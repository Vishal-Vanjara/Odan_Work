import 'dart:convert';

import 'package:bloc_demo/demo_3/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => UserModel.fromJson(e)).toList();
    }else{
      throw Exception("Failed to load users");
    }
  }
}
