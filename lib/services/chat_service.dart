import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/message.dart';

class ChatService {
  final baseUrl = "http://10.0.2.2:8080/v1/messages";
  final auth = AuthService();

  Future<void> sendMessage(String text, int receiverId) async {
    final token = await auth.getToken();

    await http.post(
      Uri.parse("$baseUrl/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "messageText": text,
        "receiverId": receiverId
      }),
    );
  }

  Future<List<Message>> getMessages(int userId) async {
    final token = await auth.getToken();

    final res = await http.get(
      Uri.parse("$baseUrl/conversations/get/$userId/"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(res.body);
    return (data['messages'] as List)
        .map((e) => Message.fromJson(e))
        .toList();
  }
}