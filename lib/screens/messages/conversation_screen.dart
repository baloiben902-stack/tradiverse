import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/messaging_service.dart';

class ConversationScreen extends StatefulWidget {
  final String otherUserName;
  final String itemTitle;
  final String offeredItem;
  final String cashDifference;
  final String offerMessage;
  final String conversationId;
  final String receiverId;

  const ConversationScreen({
    super.key,
    required this.otherUserName,
    required this.itemTitle,
    this.offeredItem = '',
    this.cashDifference = '',
    this.offerMessage = '',
    this.conversationId = '',
    this.receiverId = '',
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController messageController = TextEditingController();
  final MessagingService messagingService = MessagingService();

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
  bool showStickerPicker = false;
  final List<String> stickers = [
    'lets_trade',
    'swap',
    'fair_value',
    'make_offer',
    'interested',
    'let_me_think',
    'hot_trade',
    'deal',
    'trade_complete',
    'trusted_trade',
    'great_trader',
    'ready_to_swap',
    'send_offer',
    'win_win',
    'no_deal',
    'counter_offer',
    'what_value',
    'trade_anywhere',
  ];

  String tradeOfferStatus = 'Pending';
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingPath;

  String stickerLabel(String id) {
    const labels = {
      'lets_trade': '🤝 LET’S TRADE',
      'swap': '🔄 SWAP?',
      'fair_value': '💰 FAIR VALUE',
      'make_offer': '🏷️ MAKE AN OFFER',
      'interested': '👀 I’M INTERESTED',
      'let_me_think': '🤔 LET ME THINK',
      'hot_trade': '🔥 HOT TRADE',
      'deal': '✅ DEAL!',
      'trade_complete': '🎉 TRADE COMPLETE',
      'trusted_trade': '🛡️ TRUSTED TRADE',
      'great_trader': '⭐ GREAT TRADER',
      'ready_to_swap': '📦 READY TO SWAP',
      'send_offer': '💬 SEND YOUR OFFER',
      'win_win': '🤝 WIN-WIN',
      'no_deal': '❌ NO DEAL',
      'counter_offer': '🔁 COUNTER-OFFER',
      'what_value': '🧮 WHAT’S THE VALUE?',
      'trade_anywhere': '🌍 TRADE ANYWHERE',
    };

    return labels[id] ?? id;
  }

  @override
  void initState() {
    super.initState();
    if (widget.conversationId.isNotEmpty) {
      messagingService.markConversationAsRead(widget.conversationId);
    }
  }

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Voice note recorded.')));
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

    await audioRecorder.start(const RecordConfig(), path: path);

    setState(() {
      isRecording = true;
      recordingPath = null;
    });
  }

  Future<void> _sendSticker(String stickerId) async {
    if (widget.conversationId.isEmpty || widget.receiverId.isEmpty) {
      return;
    }

    try {
      await messagingService.sendSticker(
        conversationId: widget.conversationId,
        receiverId: widget.receiverId,
        stickerId: stickerId,
      );

      if (mounted) {
        setState(() {
          showStickerPicker = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sticker failed: $e')));
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    if (widget.conversationId.isNotEmpty && widget.receiverId.isNotEmpty) {
      try {
        await messagingService.sendMessage(
          conversationId: widget.conversationId,
          receiverId: widget.receiverId,
          text: text,
        );

        if (mounted) {
          messageController.clear();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Message failed: $e')));
        }
      }
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Messaging requires a valid conversation.'),
        ),
      );
    }
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
              border: Border.all(color: const Color(0xFFE2E8F0)),
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
            child: widget.conversationId.isEmpty
                ? const Center(child: Text('Start the conversation'))
                : StreamBuilder(
                    stream: messagingService.messagesStream(
                      widget.conversationId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Unable to load messages'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final docs = snapshot.data?.docs ?? [];

                      if (docs.isEmpty) {
                        return const Center(
                          child: Text('Start the conversation'),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data = docs[index].data();
                          final text = data['text'] as String? ?? '';
                          final senderId = data['senderId'] as String? ?? '';

                          return Align(
                            alignment: senderId == widget.receiverId
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: const Color(0xFF176B4D),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          if (showStickerPicker)
            Container(
              height: 220,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: GridView.builder(
                itemCount: stickers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  final stickerId = stickers[index];

                  return InkWell(
                    onTap: () => _sendSticker(stickerId),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F4EE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        stickerLabel(stickerId),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17684D),
                        ),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        showStickerPicker = !showStickerPicker;
                        if (showStickerPicker) {
                          showEmojiPicker = false;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.sticky_note_2_outlined,
                      color: Color(0xFF176B4D),
                    ),
                    tooltip: 'Tradiverse stickers',
                  ),
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
                      color: isRecording ? Colors.red : const Color(0xFF17684D),
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
