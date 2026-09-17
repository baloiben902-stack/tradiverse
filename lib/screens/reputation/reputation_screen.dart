import 'package:flutter/material.dart';

class ReputationScreen extends StatelessWidget {
  const ReputationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const trustScore = 85;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text('Reputation'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Text(
                  'Trust Score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '$trustScore',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF176B4D),
                  ),
                ),
                const Text(
                  'Trusted Trader',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildStatsCard(),
          const SizedBox(height: 20),
          _buildReviewsCard(),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return _card(
      title: 'Trade Record',
      children: const [
        _StatRow(label: 'Completed Trades', value: '12'),
        _StatRow(label: 'Successful Trades', value: '11'),
        _StatRow(label: 'Reviews Received', value: '9'),
        _StatRow(label: 'Average Rating', value: '4.8 / 5'),
      ],
    );
  }

  Widget _buildReviewsCard() {
    return _card(
      title: 'Recent Reviews',
      children: const [
        _ReviewRow(
          name: 'Tradiverse Trader',
          rating: 5,
          comment: 'Smooth and trustworthy trade.',
        ),
        SizedBox(height: 16),
        _ReviewRow(
          name: 'Community Trader',
          rating: 5,
          comment: 'Great communication and delivery.',
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;

  const _ReviewRow({
    required this.name,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              children: List.generate(
                rating,
                (_) => const Icon(
                  Icons.star_rounded,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          comment,
          style: const TextStyle(
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
