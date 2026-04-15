class Message {
  final int? id;
  final String messageText;
  final int receiverId;

  Message({
    this.id,
    required this.messageText,
    required this.receiverId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      messageText: json['messageText'],
      receiverId: json['receiverId'],
    );
  }
}