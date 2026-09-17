import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConversationService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ConversationService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> conversationsStream() {
    final user = _auth.currentUser;

    if (user == null) {
      throw StateError('User must be authenticated.');
    }

    return _firestore
        .collection('conversations')
        .where('participants', arrayContains: user.uid)
        .orderBy('lastMessageAt', descending: true)
        .snapshots();
  }
}
