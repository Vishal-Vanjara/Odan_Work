import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';


class UserApiService {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
}
