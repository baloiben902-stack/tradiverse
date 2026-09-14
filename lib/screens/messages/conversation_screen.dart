import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String otherUserName;
  final String itemTitle;

  const ConversationScreen({
    super.key,
    required this.otherUserName,
    required this.itemTitle,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<String> messages = [];

  final List<String> emojis = [
    '😀',
    '😂',
    '😍',
    '😊',
    '👍',
    '❤️',
    '🔥',
    '👏',
    '🙏',
    '🤝',
    '🎉',
    '💯',
    '😎',
    '😉',
    '😢',
    '😮',
    '🤔',
    '🙌',
    '💚',
    '🌍',
  ];

  bool showEmojiPicker = false;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
      messageController.clear();
    });
  }

  void _addEmoji(String emoji) {
    setState(() {
      messageController.text += emoji;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(
          widget.otherUserName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              'Trade: ${widget.itemTitle}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text('Start the conversation'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: const Color(0xFF176B4D),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            messages[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (showEmojiPicker)
            Container(
              height: 210,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: GridView.builder(
                itemCount: emojis.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _addEmoji(emojis[index]),
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                      child: Text(
                        emojis[index],
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  );
                },
              ),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showEmojiPicker = !showEmojiPicker;
                      });
                    },
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Color(0xFF176B4D),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
