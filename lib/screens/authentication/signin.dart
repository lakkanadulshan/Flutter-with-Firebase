import 'package:flutter/material.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({super.key, required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = '';
  String password = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage(
                      'assets/images/profile-pic.avif',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      dynamic result = await _auth.signInWithEmailAndPassword(
                        email.trim(),
                        password,
                      );

                      if (!context.mounted) return;

                      if (result == null) {
                        print('Error signing in');
                      } else {
                        print('Signed in successfully');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      }
                    } catch (error) {
                      print(error.toString());
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () async {
                    var user = await _auth.signInWithGoogle();
                    if (!context.mounted) return;

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const Home()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _auth.lastAuthError ?? 'Google sign in failed',
                          ),
                        ),
                      );
                    }
                  },
                  icon: Image.asset(
                    'assets/images/google-logo-removebg-preview.png',
                    width: 20,
                    height: 20,
                  ),
                  label: const Text('Continue with Google'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    try {
                      dynamic result = await _auth.signinanonymous();

                      if (!context.mounted) return;

                      if (result == null) {
                        print('Error signing in as guest');
                      } else {
                        print('Guest sign in successful');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      }
                    } catch (error) {
                      print(error.toString());
                    }
                  },
                  child: const Text('Login as Guest'),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        widget.toggle();
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
