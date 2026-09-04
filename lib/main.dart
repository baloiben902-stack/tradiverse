import 'package:flutter/material.dart';

void main() {
  runApp(const TradiverseApp());
}

class TradiverseApp extends StatelessWidget {
  const TradiverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tradiverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        useMaterial3: true,
      ),
      home: const TradiverseHome(),
    );
  }
}

class TradiverseHome extends StatelessWidget {
  const TradiverseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tradiverse',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Trade Anything.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Value Everything.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Turn what you have into what you need.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 28),
            Card(
              child: ListTile(
                leading: const Icon(Icons.swap_horiz, size: 40),
                title: const Text(
                  'Start a Trade',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Offer something you have and discover what you can receive.',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.auto_awesome, size: 40),
                title: const Text(
                  'Tradiverse AI',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Intelligent matching for better exchanges.',
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Explore Tradiverse',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}EOF
