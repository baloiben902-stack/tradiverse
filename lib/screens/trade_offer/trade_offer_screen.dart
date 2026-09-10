import 'package:flutter/material.dart';

class TradeOfferScreen extends StatefulWidget {
  final String itemTitle;
  final String itemValue;

  const TradeOfferScreen({
    super.key,
    required this.itemTitle,
    required this.itemValue,
  });

  @override
  State<TradeOfferScreen> createState() => _TradeOfferScreenState();
}

class _TradeOfferScreenState extends State<TradeOfferScreen> {
  final TextEditingController offerController = TextEditingController();
  final TextEditingController cashController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    offerController.dispose();
    cashController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text(
          'Make a Trade Offer',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 22),
              _buildYouWantCard(),
              const SizedBox(height: 18),
              _buildCashCard(),
              const SizedBox(height: 18),
              _buildValueCard(),
              const SizedBox(height: 18),
              _buildMessageCard(),
              const SizedBox(height: 22),
              _buildSafetyCard(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Trade offer ready to be sent.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_rounded),
                  label: const Text(
                    'Send Trade Offer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176B4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF176B4D),
            Color(0xFF238A63),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.swap_horizontal_circle_rounded,
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(height: 14),
          const Text(
            'Exchange value, not just money.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Create an offer for ${widget.itemTitle}.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYouWantCard() {
    return _sectionCard(
      icon: Icons.inventory_2_outlined,
      title: 'What are you offering?',
      child: Column(
        children: [
          TextField(
            controller: offerController,
            decoration: InputDecoration(
              hintText: 'Example: Smartphone, service, skill...',
              prefixIcon: const Icon(Icons.add_box_outlined),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _quickOffer(
                  Icons.phone_android_rounded,
                  'Phone',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _quickOffer(
                  Icons.handyman_outlined,
                  'Service',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _quickOffer(
                  Icons.more_horiz_rounded,
                  'Other',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCashCard() {
    return _sectionCard(
      icon: Icons.payments_outlined,
      title: 'Add cash difference',
      child: TextField(
        controller: cashController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Optional',
          prefixText: 'R ',
          prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildValueCard() {
    return _sectionCard(
      icon: Icons.balance_rounded,
      title: 'Tradiverse Value Check',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF7F1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF176B4D),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estimated listing value',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.itemValue,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'AI valuation will be connected later.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard() {
    return _sectionCard(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'Message the trader',
      child: TextField(
        controller: messageController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText:
              'Explain why your offer is valuable...',
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSafetyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE4E9EF),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: Color(0xFF176B4D),
            size: 28,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Trade safely. Never share sensitive banking or personal information in a trade message.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF176B4D),
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _quickOffer(IconData icon, String label) {
    return InkWell(
      onTap: () {
        offerController.text = label;
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
