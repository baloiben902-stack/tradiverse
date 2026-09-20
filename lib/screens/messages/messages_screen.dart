import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/conversation_service.dart';
import 'conversation_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversationService = ConversationService();
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: currentUser == null
          ? const Center(child: Text('Please sign in to view messages.'))
          : StreamBuilder(
              stream: conversationService.conversationsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Unable to load conversations'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final conversations = snapshot.data?.docs ?? [];

                if (conversations.isEmpty) {
                  return const Center(child: Text('No conversations yet'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final document = conversations[index];
                    final data = document.data();

                    final participants = List<String>.from(
                      data['participants'] ?? [],
                    );

                    final otherUserId = participants.firstWhere(
                      (id) => id != currentUser.uid,
                      orElse: () => '',
                    );

                    final lastMessage = data['lastMessage'] as String? ?? '';

                    final tradeId = data['tradeId'] as String? ?? '';

                    return _conversationTile(
                      context,
                      conversationId: document.id,
                      receiverId: otherUserId,
                      item: tradeId.isEmpty
                          ? 'Trade conversation'
                          : 'Trade: $tradeId',
                      lastMessage: lastMessage,
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _conversationTile(
    BuildContext context, {
    required String conversationId,
    required String receiverId,
    required String item,
    required String lastMessage,
  }) {
    return InkWell(
      onTap: receiverId.isEmpty
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConversationScreen(
                    otherUserName: 'Tradiverse Trader',
                    itemTitle: item,
                    conversationId: conversationId,
                    receiverId: receiverId,
                  ),
                ),
              );
            },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFE5F2EC),
              child: Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF176B4D),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tradiverse Trader',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastMessage.isEmpty ? item : lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
