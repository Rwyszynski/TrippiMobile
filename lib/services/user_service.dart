import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'auth_service.dart';

class UserService {
  final String baseUrl = "http://10.0.2.2:8080/v1/users";
  final auth = AuthService();

  Future<List<User>> getUsers() async {
    final token = await auth.getToken();

    final res = await http.get(
      Uri.parse("$baseUrl/all"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(res.body);
    return (data['users'] as List)
        .map((e) => User.fromJson(e))
        .toList();
  }
}