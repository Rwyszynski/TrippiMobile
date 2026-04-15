import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder(
        future: userService.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final users = snapshot.data as List;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) {
              return ListTile(
                title: Text(users[i]['name'] ?? "User"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(userId: users[i]['id']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}