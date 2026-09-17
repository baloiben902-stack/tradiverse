import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  MessagingService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream(
    String conversationId,
  ) {
    return _firestore
        .collection('messages')
        .where('conversationId', isEqualTo: conversationId)
        .orderBy('createdAt')
        .snapshots();
  }

  Future<void> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw StateError('User must be authenticated to send a message.');
    }

    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      throw ArgumentError('Message cannot be empty.');
    }

    await _firestore.collection('messages').add({
      'conversationId': conversationId,
      'senderId': user.uid,
      'receiverId': receiverId,
      'text': cleanText,
      'type': 'text',
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  Future<void> markConversationAsRead(String conversationId) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw StateError('User must be authenticated.');
    }

    final snapshot = await _firestore
        .collection('messages')
        .where('conversationId', isEqualTo: conversationId)
        .where('receiverId', isEqualTo: user.uid)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();

    for (final document in snapshot.docs) {
      batch.update(document.reference, {'isRead': true});
    }

    await batch.commit();
  }
}
