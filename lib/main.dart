import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TradiverseApp());
}

class TradiverseApp extends StatefulWidget {
  const TradiverseApp({super.key});

  @override
  State<TradiverseApp> createState() => _TradiverseAppState();
}

class _TradiverseAppState extends State<TradiverseApp> {
  String status = 'Starting Tradiverse...';
  bool firebaseReady = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (!mounted) return;

      setState(() {
        firebaseReady = true;
        status = 'Firebase initialized successfully.';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        status = 'Firebase initialization failed:\\n\\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tradiverse',
      debugShowCheckedModeBanner: false,
      home: firebaseReady
          ? const HomeScreen()
          : Scaffold(
              appBar: AppBar(
                title: const Text('Tradiverse Startup'),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
    );
  }
}
