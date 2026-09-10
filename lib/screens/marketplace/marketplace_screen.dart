import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Marketplace',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search items, skills or services',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _CategoryCard(
                    icon: Icons.devices,
                    title: 'Electronics',
                  ),
                  _CategoryCard(
                    icon: Icons.directions_car,
                    title: 'Vehicles',
                  ),
                  _CategoryCard(
                    icon: Icons.home,
                    title: 'Property',
                  ),
                  _CategoryCard(
                    icon: Icons.handyman,
                    title: 'Services',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Available for Trade',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            const _ListingCard(
              icon: Icons.laptop_mac,
              title: 'Laptop',
              value: 'R8,000',
              description: 'Good condition • Johannesburg',
            ),

            const _ListingCard(
              icon: Icons.build,
              title: 'Construction Services',
              value: 'R6,000',
              description: 'Skilled labour • Gauteng',
            ),

            const _ListingCard(
              icon: Icons.phone_android,
              title: 'Smartphone',
              value: 'R5,500',
              description: 'Excellent condition • Johannesburg',
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CategoryCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;

  const _ListingCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey.shade100,
              ),
              child: Icon(icon, size: 38),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                  const SizedBox(height: 6),
                  Text(
                    'Estimated value: $value',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
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
}
