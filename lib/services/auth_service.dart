import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8080/v1/auth";
  final storage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/token"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );

    if (res.statusCode == 200) {
      final token = jsonDecode(res.body)['token'];
      await storage.write(key: "jwt", value: token);
    } else {
      throw Exception("Login failed");
    }
  }

  Future<void> register(String email, String password) async {
    await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );
  }

  Future<String?> getToken() async {
    return await storage.read(key: "jwt");
  }
}