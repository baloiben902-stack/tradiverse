class ConversationModel {
  final String id;
  final String participantOneId;
  final String participantTwoId;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final String tradeId;

  const ConversationModel({
    required this.id,
    required this.participantOneId,
    required this.participantTwoId,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.tradeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'participantOneId': participantOneId,
      'participantTwoId': participantTwoId,
      'lastMessage': lastMessage,
      'lastMessageAt': lastMessageAt,
      'tradeId': tradeId,
    };
  }

  factory ConversationModel.fromMap(String id, Map<String, dynamic> map) {
    return ConversationModel(
      id: id,
      participantOneId: map['participantOneId'] as String? ?? '',
      participantTwoId: map['participantTwoId'] as String? ?? '',
      lastMessage: map['lastMessage'] as String? ?? '',
      lastMessageAt: _parseDate(map['lastMessageAt']),
      tradeId: map['tradeId'] as String? ?? '',
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;

    try {
      return value.toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }
}
