import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login will be connected to Firebase soon.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              Center(
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swap_horiz_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Welcome to Tradiverse',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Trade Anything. Value Everything.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 42),

              const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password reset will be connected to Firebase.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Google Sign-In will be connected to Firebase.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.g_mobiledata_rounded),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
