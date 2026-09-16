import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class ConversationScreen extends StatefulWidget {
  final String otherUserName;
  final String itemTitle;
  final String offeredItem;
  final String cashDifference;
  final String offerMessage;

  const ConversationScreen({
    super.key,
    required this.otherUserName,
    required this.itemTitle,
    this.offeredItem = '',
    this.cashDifference = '',
    this.offerMessage = '',
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
  String tradeOfferStatus = 'Pending';
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingPath;

  @override
  void dispose() {
    messageController.dispose();
    audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (isRecording) {
      final path = await audioRecorder.stop();

      setState(() {
        isRecording = false;
        recordingPath = path;
      });

      if (path != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice note recorded.')),
        );
      }
      return;
    }

    final hasPermission = await audioRecorder.hasPermission();

    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission is required.')),
        );
      }
      return;
    }

    final directory = await getTemporaryDirectory();
    final path =
        '${directory.path}/tradiverse_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await audioRecorder.start(
      const RecordConfig(),
      path: path,
    );

    setState(() {
      isRecording = true;
      recordingPath = null;
    });
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.swap_horiz_rounded,
                      color: Color(0xFF176B4D),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Trade Offer',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      tradeOfferStatus,
                      style: TextStyle(
                        color: tradeOfferStatus == 'Accepted'
                            ? const Color(0xFF176B4D)
                            : tradeOfferStatus == 'Declined'
                                ? Colors.red
                                : Colors.orange.shade700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Offering: ${widget.offeredItem.isEmpty ? 'Not specified' : widget.offeredItem}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (widget.cashDifference.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text('Cash difference: ${widget.cashDifference}'),
                ],
                if (widget.offerMessage.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text('Message: ${widget.offerMessage}'),
                ],
                if (tradeOfferStatus == 'Pending') ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              tradeOfferStatus = 'Declined';
                            });
                          },
                          child: const Text('Decline'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              tradeOfferStatus = 'Accepted';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF176B4D),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Accept'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
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
                  IconButton(
              onPressed: _toggleRecording,
              icon: Icon(
                isRecording
                    ? Icons.stop_circle_outlined
                    : Icons.mic_none_rounded,
                color: isRecording
                    ? Colors.red
                    : const Color(0xFF17684D),
              ),
              tooltip: isRecording ? 'Stop recording' : 'Voice note',
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
