import 'package:flutter/material.dart';

class MyTradesScreen extends StatelessWidget {
  const MyTradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text(
          'My Trades',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Active Trade'),
          const SizedBox(height: 12),
          _buildTradeCard(context),
          const SizedBox(height: 28),
          _buildSectionTitle('Trade Status'),
          const SizedBox(height: 12),
          _buildStatusCard(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Color(0xFF172033),
      ),
    );
  }

  Widget _buildTradeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 7),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5EF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.swap_horiz_rounded,
                  color: Color(0xFF176B4D),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Active Trade',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _statusChip('Accepted'),
            ],
          ),
          const SizedBox(height: 20),
          _tradeRow(
            Icons.inventory_2_outlined,
            'You receive',
            'Smartphone',
          ),
          const SizedBox(height: 14),
          _tradeRow(
            Icons.handshake_outlined,
            'You give',
            'Construction Services',
          ),
          const SizedBox(height: 14),
          _tradeRow(
            Icons.person_outline_rounded,
            'Trading with',
            'Tradiverse Trader',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Trade completion will be connected next.'),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: const Text(
                'Complete Trade',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176B4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tradeRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF64748B),
          size: 22,
        ),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Color(0xFF176B4D),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          _StatusStep(
            icon: Icons.send_rounded,
            title: 'Offer sent',
            completed: true,
          ),
          _StatusStep(
            icon: Icons.check_circle_outline_rounded,
            title: 'Offer accepted',
            completed: true,
          ),
          _StatusStep(
            icon: Icons.swap_horiz_rounded,
            title: 'Trade in progress',
            completed: true,
          ),
          _StatusStep(
            icon: Icons.done_all_rounded,
            title: 'Trade completed',
            completed: false,
          ),
        ],
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool completed;

  const _StatusStep({
    required this.icon,
    required this.title,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(
            icon,
            color: completed
                ? const Color(0xFF176B4D)
                : const Color(0xFFCBD5E1),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: completed
                  ? const Color(0xFF172033)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
