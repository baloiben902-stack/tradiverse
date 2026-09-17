class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final String type;
  final DateTime createdAt;
  final bool isRead;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.createdAt,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type,
      'createdAt': createdAt,
      'isRead': isRead,
    };
  }

  factory MessageModel.fromMap(String id, Map<String, dynamic> map) {
    return MessageModel(
      id: id,
      conversationId: map['conversationId'] as String? ?? '',
      senderId: map['senderId'] as String? ?? '',
      receiverId: map['receiverId'] as String? ?? '',
      text: map['text'] as String? ?? '',
      type: map['type'] as String? ?? 'text',
      createdAt: _parseCreatedAt(map['createdAt']),
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  static DateTime _parseCreatedAt(dynamic value) {
    if (value is DateTime) return value;
    if (value != null) {
      try {
        return value.toDate() as DateTime;
      } catch (_) {}
    }
    return DateTime.now();
  }
}
