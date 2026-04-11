import 'package:brew_crew/screens/authentication/register.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signout();
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Register(toggle: () {})),
              );
            },
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Sign out'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Brew Crew',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Track your favorite brews and stay connected with your crew.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  _HomeTile(
                    icon: Icons.local_cafe_outlined,
                    title: 'Today\'s Brew',
                    subtitle: 'No brew selected yet',
                  ),
                  SizedBox(height: 12),
                  _HomeTile(
                    icon: Icons.people_outline,
                    title: 'Community',
                    subtitle: 'See what others are brewing',
                  ),
                  SizedBox(height: 12),
                  _HomeTile(
                    icon: Icons.settings_outlined,
                    title: 'Preferences',
                    subtitle: 'Update your brew strength and sugar',
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

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HomeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
